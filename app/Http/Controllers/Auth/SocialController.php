<?php
// app/Http/Controllers/Auth/SocialController.php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Registered;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Throwable;

class SocialController extends Controller
{
    public function redirectGoogle()
    {
        // Если есть проблемы с сессиями (InvalidStateException) и это SPA/поддомен,
        // можно временно добавить ->stateless(), но лучше починить сессии (см. раздел 6).
        return Socialite::driver('google')
            ->scopes(['email', 'profile'])
            ->redirect();
    }

    public function callbackGoogle()
    {
        try {
            $socialUser = Socialite::driver('google')->user();
        } catch (Throwable $e) {
            // На случай InvalidStateException / сетевых ошибок
            return redirect()->route('login')->withErrors([
                'google' => 'Не удалось авторизоваться через Google. Попробуйте ещё раз.',
            ]);
        }

        $email = $socialUser->getEmail() ?: 'google_'.$socialUser->getId().'@example.local';

        $user = User::firstOrCreate(
            ['email' => $email],
            [
                'name'     => $socialUser->getName() ?: ($socialUser->getNickname() ?: 'User'),
                'password' => bcrypt(Str::random(32)),
            ]
        );

        // опционально: сохранить метаданные oauth в json-колонку
        if (property_exists($user, 'oauth')) {
            $user->oauth = array_merge((array)$user->oauth, [
                'google' => [
                    'id'    => $socialUser->getId(),
                    'email' => $email,
                ],
            ]);
            $user->save();
        }

        // При желании можно сразу верифицировать почту, но обычно достаточно обычного flow
        if (!$user->hasVerifiedEmail() && method_exists($user, 'markEmailAsVerified')) {
            $user->markEmailAsVerified();
        }

        event(new Registered($user));

        Auth::login($user, true);

        return redirect()->intended(route('dashboard'));
    }
}
