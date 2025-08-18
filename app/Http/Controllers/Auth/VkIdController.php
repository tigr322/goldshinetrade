<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class VkIdController extends Controller
{
    private string $issuer = 'https://id.vk.com'; // базовый Issuer
    private string $authUrl = 'https://id.vk.com/authorize';


    /** BASE64URL без паддингов (=) */
    private function base64url(string $bin): string
    {
        return rtrim(strtr(base64_encode($bin), '+/', '-_'), '=');
    }

    /** Генерация пары PKCE */
    private function makePkce(): array
    {
        // Версифер 43..128 символов. Возьмем 64 байта.
        $verifier  = $this->base64url(random_bytes(64));
        $challenge = $this->base64url(hash('sha256', $verifier, true));
        return [$verifier, $challenge];
    }

    public function redirect(Request $request)
    {
        $clientId    = config('services.vkontakte.client_id', env('VKONTAKTE_CLIENT_ID'));
        $redirectUri = config('services.vkontakte.redirect', env('VKONTAKTE_REDIRECT_URI'));
        $scope       = env('VKONTAKTE_ID_SCOPE', 'openid email'); 

        // CSRF и nonce
        $state = Str::random(32);
        $nonce = Str::random(32);
        $request->session()->put('vkid_state', $state);
        $request->session()->put('vkid_nonce', $nonce);

        // PKCE
        [$verifier, $challenge] = $this->makePkce();
        $request->session()->put('vkid_pkce_verifier', $verifier);

        // Авторизация
        $query = http_build_query([
            'client_id'              => $clientId,
            'redirect_uri'           => $redirectUri,
            'response_type'          => 'code',
            'scope'                  => $scope,            // будет url-энкодед автоматически
            'state'                  => $state,
            'nonce'                  => $nonce,
            'code_challenge'         => $challenge,
            'code_challenge_method'  => 'S256',           // ВАЖНО: именно S256
        ]);

        return redirect($this->authUrl.'?'.$query);
    }

    private function oidcConfig(): array
    {
        return Cache::remember('vkid_oidc_config', 60, function () {
            $url = rtrim($this->issuer, '/').'/.well-known/openid-configuration';
            $resp = Http::acceptJson()->get($url);
    
            Log::info('VKID discovery response', ['status' => $resp->status(), 'body' => $resp->json()]);
            if (!$resp->ok() || !is_array($resp->json())) {
                throw new \RuntimeException('VKID discovery failed: status='.$resp->status());
            }
            return $resp->json();
        });
    }
    public function callback(Request $request)
{
    // 1) Проверка state
    $savedState = $request->session()->pull('vk_state');
    if (!$request->has('state') || $request->state !== $savedState) {
        \Log::warning('VK callback: invalid state', ['expected' => $savedState, 'got' => $request->get('state')]);
        abort(403, 'Invalid state');
    }
    if (!$request->has('code')) {
        \Log::error('VK callback: no code', ['query' => $request->query()]);
        return redirect()->route('login')->withErrors(['vk' => 'Не получили код авторизации']);
    }

    $clientId     = config('services.vkontakte.client_id');
    $clientSecret = config('services.vkontakte.client_secret');
    $redirectUri  = config('services.vkontakte.redirect');

    // 2) Обмен кода на токен (VK ожидает access_token на oauth.vk.com/access_token)
    $tokenResp = Http::get('https://oauth.vk.com/access_token', [
        'client_id'     => $clientId,
        'client_secret' => $clientSecret,
        'redirect_uri'  => $redirectUri,
        'code'          => $request->code,
    ]);

    \Log::info('VK token response', ['status' => $tokenResp->status(), 'body' => $tokenResp->json(), 'raw' => $tokenResp->body()]);

    if (!$tokenResp->ok() || !is_array($tokenResp->json())) {
        return redirect()->route('login')->withErrors(['vk' => 'VK: не удалось получить токен (проверь redirect_uri и настройки приложения)']);
    }

    $token = $tokenResp->json();
    $accessToken = $token['access_token'] ?? null;
    $vkUserId    = $token['user_id']      ?? null;
    $email       = $token['email']        ?? null; // приходит ТОЛЬКО если запрошен scope=email

    if (!$accessToken || !$vkUserId) {
        \Log::error('VK token: missing fields', ['token' => $token]);
        return redirect()->route('login')->withErrors(['vk' => 'VK: в ответе на токен нет access_token или user_id']);
    }

    // 3) Берём профиль через users.get
    $userResp = Http::get('https://api.vk.com/method/users.get', [
        'user_ids' => $vkUserId,
        'fields'   => 'photo_200,screen_name,sex,bdate',
        'access_token' => $accessToken,
        'v'       => '5.131',
    ]);

    \Log::info('VK users.get response', ['status' => $userResp->status(), 'body' => $userResp->json(), 'raw' => $userResp->body()]);

    $data = $userResp->json();
    $profile = $data['response'][0] ?? null;
    if (!$profile) {
        return redirect()->route('login')->withErrors(['vk' => 'VK: не удалось получить профиль пользователя']);
    }

    $name = trim(($profile['first_name'] ?? '') . ' ' . ($profile['last_name'] ?? '')) ?: 'VK User';
    if (!$email) {
        // Если VK не вернул email, подставим служебный
        $email = "vk_{$vkUserId}@example.local";
    }

    // 4) Локальный пользователь
    $user = \App\Models\User::firstOrCreate(
        ['email' => $email],
        ['name' => $name, 'password' => bcrypt(Str::random(32))]
    );

    $user->oauth = array_merge((array)$user->oauth, [
        'vk' => [
            'id'    => $vkUserId,
            'email' => $token['email'] ?? null,
            'screen_name' => $profile['screen_name'] ?? null,
            'photo' => $profile['photo_200'] ?? null,
        ],
    ]);
    $user->save();

    if (method_exists($user, 'markEmailAsVerified') && is_null($user->email_verified_at)) {
        $user->markEmailAsVerified();
    }

    Auth::login($user, true);
    \Log::info('VK callback: user logged in', ['user_id' => $user->id, 'email' => $user->email]);

    return redirect()->intended(route('dashboard'));
}

}
