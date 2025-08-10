<?php
// app/Http/Controllers/Auth/SocialController.php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Registered;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class SocialController extends Controller
{
    public function redirect(string $provider)
    {
        if ($provider === 'vkontakte') {
            return Socialite::driver('vkontakte')
                ->scopes(['email'])
                ->redirect();
        }

        // Для Google полезно явно запросить email/openid
        if ($provider === 'google') {
            return Socialite::driver('google')
                ->scopes(['openid', 'email', 'profile'])
                ->redirect();
        }

        return Socialite::driver($provider)->redirect();
    }

    public function callback(string $provider)
    {
        $socialUser = Socialite::driver($provider)->user();

        // VK: email может быть тут или в $socialUser->user['email']
        $email = $socialUser->getEmail()
              ?: ($socialUser->user['email'] ?? null);

        // Если email не пришёл — подставим служебный
        $email = $email ?: "{$provider}_{$socialUser->getId()}@example.local";

        $user = User::firstOrCreate(
            ['email' => $email],
            [
                'name'     => $socialUser->getName() ?: ($socialUser->getNickname() ?: 'User'),
                'password' => bcrypt(str()->random(32)),
            ]
        );

        // Немного OAuth-меты (если есть json-колонка oauth)
        $user->oauth = array_merge((array) $user->oauth, [
            $provider => [
                'id'    => $socialUser->getId(),
                'email' => $email,
                'raw'   => $socialUser->user ?? [], // полезно для отладки
            ],
        ]);

        // >>> АВТО-ПОДТВЕРЖДЕНИЕ ДЛЯ GOOGLE <<<
        if ($provider === 'google') {
            $googleVerified = (bool)($socialUser->user['email_verified'] ?? $socialUser->user['verified_email'] ?? false);

            // Если Google подтвердил email и наш юзер ещё не верифицирован — верифицируем
            if ($googleVerified && is_null($user->email_verified_at)) {
                $user->email_verified_at = now();
            }
        }

        $user->save();

        // Событие регистрации (можно оставить — некоторые слушатели что-то делают)
        event(new Registered($user));

        Auth::login($user);

        // Письмо с подтверждением отправляем только если всё ещё не подтверждён
        if (method_exists($user, 'hasVerifiedEmail')) {
            if (!$user->hasVerifiedEmail()) {
                $user->sendEmailVerificationNotification();
            }
        } elseif (is_null($user->email_verified_at)) {
            $user->sendEmailVerificationNotification();
        }

        return redirect()->intended(route('dashboard'));
    }
}
