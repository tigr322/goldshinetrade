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

        return Socialite::driver($provider)->redirect();
    }

    public function callback(string $provider)
    {
        $socialUser = Socialite::driver($provider)->user();

        // Для VK email может быть в $socialUser->getEmail() или $socialUser->user['email']
        $email = $socialUser->getEmail()
              ?: ($socialUser->user['email'] ?? null);

        // Если email не пришёл — подставляем служебный (иначе unique(email) не пройдёт)
        $email = $email ?: "{$provider}_{$socialUser->getId()}@example.local";

        $user = User::firstOrCreate(
            ['email' => $email],
            [
                'name'     => $socialUser->getName() ?: ($socialUser->getNickname() ?: 'User'),
                'password' => bcrypt(str()->random(32)),
            ]
        );

        // сохраним немного OAuth-меты (если есть json-колонка oauth)
        $user->oauth = array_merge((array) $user->oauth, [
            $provider => [
                'id'    => $socialUser->getId(),
                'email' => $email,
            ],
        ]);
        $user->save();

        event(new Registered($user));
      
        Auth::login($user);
        $user->sendEmailVerificationNotification();

        return redirect()->intended(route('dashboard'));
    }
}
