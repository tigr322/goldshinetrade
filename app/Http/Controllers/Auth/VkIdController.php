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
        $savedState = $request->session()->pull('vkid_state');
        if (!$request->has('state') || $request->state !== $savedState) {
            Log::warning('VKID callback: invalid state', ['expected' => $savedState, 'got' => $request->get('state')]);
            abort(403, 'Invalid state');
        }
        if (!$request->has('code')) {
            Log::error('VKID callback: no code', ['query' => $request->query()]);
            return redirect()->route('login')->withErrors(['vk' => 'Не получили код авторизации']);
        }
    
        // 2) Берём актуальные endpoint'ы из discovery
        try {
            $cfg = $this->oidcConfig();
        } catch (\Throwable $e) {
            Log::error('VKID discovery error', ['e' => $e->getMessage()]);
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: не удалось получить конфигурацию провайдера']);
        }
    
        $tokenUrl   = $cfg['token_endpoint']     ?? null;
        $userUrl    = $cfg['userinfo_endpoint']  ?? null;
        if (!$tokenUrl || !$userUrl) {
            Log::error('VKID discovery missing endpoints', ['cfg' => $cfg]);
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: не найдены token/userinfo endpoints']);
        }
    
        // 3) Обмен кода на токен (PKCE)
        $clientId     = config('services.vkontakte.client_id', env('VKONTAKTE_CLIENT_ID'));
        $clientSecret = config('services.vkontakte.client_secret', env('VKONTAKTE_CLIENT_SECRET')); // опционально
        $redirectUri  = config('services.vkontakte.redirect', env('VKONTAKTE_REDIRECT_URI'));
        $verifier     = (string) $request->session()->pull('vkid_pkce_verifier', '');
    
        $form = [
            'grant_type'    => 'authorization_code',
            'code'          => $request->code,
            'redirect_uri'  => $redirectUri,
            'client_id'     => $clientId,
            'code_verifier' => $verifier,
        ];
        if (!empty($clientSecret)) {
            $form['client_secret'] = $clientSecret;
        }
    
        $tokenResp = Http::asForm()->post($tokenUrl, $form);
        Log::info('VKID token response', ['status' => $tokenResp->status(), 'body' => $tokenResp->json(), 'raw' => $tokenResp->body()]);
    
        if (!$tokenResp->ok()) {
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: не удалось получить токен (проверь redirect_uri / app настройки)']);
        }
    
        $token = $tokenResp->json() ?? [];
        $accessToken = $token['access_token'] ?? null;
        if (!$accessToken) {
            Log::error('VKID token: no access_token', ['token' => $token]);
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: пустой access_token']);
        }
    
        // 4) UserInfo
        $userResp = Http::withToken($accessToken)->get($userUrl);
        Log::info('VKID userinfo response', ['status' => $userResp->status(), 'body' => $userResp->json(), 'raw' => $userResp->body()]);
    
        if (!$userResp->ok() || !is_array($userResp->json())) {
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: не удалось получить профиль']);
        }
    
        $u     = $userResp->json();
        $sub   = $u['sub']   ?? null;
        $email = $u['email'] ?? null;
        $name  = $u['name']  ?? ($u['given_name'] ?? 'User');
    
        if (!$sub) {
            Log::error('VKID userinfo: empty sub', ['u' => $u]);
            return redirect()->route('login')->withErrors(['vk' => 'VK ID: профиль без идентификатора']);
        }
        if (!$email) {
            $email = "vkid_{$sub}@example.local";
        }
    
        $user = \App\Models\User::firstOrCreate(
            ['email' => $email],
            ['name' => $name, 'password' => bcrypt(Str::random(32))]
        );
    
        $user->oauth = array_merge((array)$user->oauth, [
            'vkid' => ['sub' => $sub, 'email' => $u['email'] ?? null],
        ]);
        $user->save();
    
        if (method_exists($user, 'markEmailAsVerified') && is_null($user->email_verified_at)) {
            $user->markEmailAsVerified();
        }
    
        Auth::login($user, true);
        Log::info('VKID callback: user logged in', ['user_id' => $user->id, 'email' => $user->email]);
        return redirect()->intended(route('dashboard'));
    }
}
