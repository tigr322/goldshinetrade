<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class VkIdController extends Controller
{
    private string $authUrl  = 'https://id.vk.com/authorize';
    private string $tokenUrl = 'https://id.vk.com/oauth2/token';
    private string $userUrl  = 'https://id.vk.com/api/v1/openapi/userinfo';

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
        $scope       = env('VKONTAKTE_ID_SCOPE', 'openid email'); // В .env ОБЯЗАТЕЛЬНО в кавычках: "openid email"

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

    public function callback(Request $request)
    {
        // Проверяем state
        $savedState = $request->session()->pull('vkid_state');
        if (!$request->has('state') || $request->state !== $savedState) {
            abort(403, 'Invalid state');
        }
        if (!$request->has('code')) {
            return redirect()->route('login')->withErrors(['vk' => 'Не получили код авторизации']);
        }

        $clientId     = config('services.vkontakte.client_id', env('VKONTAKTE_CLIENT_ID'));
        $clientSecret = config('services.vkontakte.client_secret', env('VKONTAKTE_CLIENT_SECRET')); // для confidential app
        $redirectUri  = config('services.vkontakte.redirect', env('VKONTAKTE_REDIRECT_URI'));
        $verifier     = (string) $request->session()->pull('vkid_pkce_verifier', '');

        // Обмен кода на токен (обязателен code_verifier!)
        $form = [
            'grant_type'    => 'authorization_code',
            'code'          => $request->code,
            'redirect_uri'  => $redirectUri,
            'client_id'     => $clientId,
            'code_verifier' => $verifier,
        ];
        // Если у вас конфиденциальное веб-приложение с секретом — добавьте:
        if (!empty($clientSecret)) {
            $form['client_secret'] = $clientSecret;
        }

        $tokenResp = Http::asForm()->post($this->tokenUrl, $form);
        if (!$tokenResp->ok()) {
            return redirect()->route('login')->withErrors(['vk' => 'Не удалось получить токен']);
        }

        $token       = $tokenResp->json();
        $accessToken = $token['access_token'] ?? null;
        if (!$accessToken) {
            return redirect()->route('login')->withErrors(['vk' => 'Пустой access_token']);
        }

        // OIDC userinfo
        $userResp = Http::withToken($accessToken)->get($this->userUrl);
        if (!$userResp->ok()) {
            return redirect()->route('login')->withErrors(['vk' => 'Не удалось получить профиль']);
        }

        $u    = $userResp->json();
        $sub  = $u['sub']   ?? null;
        $email= $u['email'] ?? null;
        $name = $u['name']  ?? ($u['given_name'] ?? 'User');

        if (!$email) {
            $email = "vkid_{$sub}@example.local";
        }

        $user = \App\Models\User::firstOrCreate(
            ['email' => $email],
            ['name' => $name, 'password' => bcrypt(Str::random(32))]
        );

        // Сохраним кусок oauth-меты (если есть json колонка)
        $user->oauth = array_merge((array)$user->oauth, [
            'vkid' => ['sub' => $sub, 'email' => $u['email'] ?? null],
        ]);
        $user->save();

        // Сразу верифицируем email, чтобы не слать письмо каждый логин
        if (method_exists($user, 'markEmailAsVerified') && is_null($user->email_verified_at)) {
            $user->markEmailAsVerified();
        }

        Auth::login($user, true);
        return redirect()->intended(route('dashboard'));
    }
}
