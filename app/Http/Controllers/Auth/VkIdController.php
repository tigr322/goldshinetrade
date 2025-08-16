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
    // VK ID эндпоинты (по докам)
    private string $authUrl   = 'https://id.vk.com/authorize';
    private string $tokenUrl  = 'https://id.vk.com/oauth2/token';
    private string $userUrl   = 'https://id.vk.com/api/v1/openapi/userinfo'; // OIDC UserInfo

    public function redirect(Request $request)
    {
        $clientId     = config('services.vkontakte.client_id', env('VKONTAKTE_CLIENT_ID'));
        $redirectUri  = config('services.vkontakte.redirect', env('VKONTAKTE_REDIRECT_URI'));
        $scope        = env('VKONTAKTE_ID_SCOPE');

        // защита от CSRF
        $state = Str::random(32);
        $nonce = Str::random(32);
        $request->session()->put('vkid_state', $state);
        $request->session()->put('vkid_nonce', $nonce);

        // базовый Authorization Code flow (без PKCE; при желании можно добавить)
        $query = http_build_query([
            'client_id'     => $clientId,
            'redirect_uri'  => $redirectUri,
            'response_type' => 'code',
            'scope'         => $scope,
            'state'         => $state,
            'nonce'         => $nonce,
        ]);

        return redirect($this->authUrl.'?'.$query);
    }

    public function callback(Request $request)
    {
        // 1) проверяем state
        if (!$request->has('state') || $request->state !== $request->session()->pull('vkid_state')) {
            abort(403, 'Invalid state');
        }

        if (!$request->has('code')) {
            return redirect()->route('login')->withErrors(['vk' => 'Не получили код авторизации']);
        }

        $clientId     = config('services.vkid.client_id', env('VKONTAKTE_CLIENT_ID'));
        $clientSecret = config('services.vkid.secret', env('VKONTAKTE_CLIENT_SECRET'));
        $redirectUri  = config('services.vkid.redirect', env('VKONTAKTE_REDIRECT_URI'));

        // 2) обмен кода на токен
        $tokenResp = Http::asForm()->post($this->tokenUrl, [
            'grant_type'    => 'authorization_code',
            'code'          => $request->code,
            'redirect_uri'  => $redirectUri,
            'client_id'     => $clientId,
            'client_secret' => $clientSecret,
        ]);

        if (!$tokenResp->ok()) {
            return redirect()->route('login')->withErrors(['vk' => 'Не удалось получить токен']);
        }

        $token = $tokenResp->json();
        $accessToken = $token['access_token'] ?? null;
        $idToken     = $token['id_token'] ?? null; // при scope=openid приходит JWT (можно валидировать, но для простоты возьмём userinfo)

        if (!$accessToken) {
            return redirect()->route('login')->withErrors(['vk' => 'Пустой access_token']);
        }

        // 3) получаем userinfo по OIDC
        $userResp = Http::withToken($accessToken)->get($this->userUrl);
        if (!$userResp->ok()) {
            return redirect()->route('login')->withErrors(['vk' => 'Не удалось получить профиль']);
        }

        $u = $userResp->json();
        // Примеры полей VK ID (по OIDC): sub, email, name, given_name, family_name, picture, etc.
        $vkSub  = $u['sub']   ?? null;      // уникальный идентификатор пользователя в VK ID
        $email  = $u['email'] ?? null;
        $name   = $u['name']  ?? ($u['given_name'] ?? 'User');

        if (!$email) {
            // Как и раньше — если email нет, подставляем служебный
            $email = "vkid_{$vkSub}@example.local";
        }

        // 4) логиним/создаём
        $user = User::firstOrCreate(
            ['email' => $email],
            [
                'name'     => $name,
                'password' => bcrypt(Str::random(32)),
            ]
        );

        // сохраним чуть-чуть метаданных (если есть json column `oauth` в users)
        $user->oauth = array_merge((array) $user->oauth, [
            'vkid' => [
                'sub'   => $vkSub,
                'email' => $u['email'] ?? null,
            ],
        ]);
        $user->save();

        // 5) НЕ требуем каждый раз подтверждение e-mail
        // Если хочешь выключить верификацию только для VK ID:
        if (method_exists($user, 'markEmailAsVerified') && is_null($user->email_verified_at)) {
            $user->markEmailAsVerified();
        }

        Auth::login($user, true);

        return redirect()->intended(route('dashboard'));
    }
}
