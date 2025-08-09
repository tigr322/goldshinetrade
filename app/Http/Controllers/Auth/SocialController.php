<?php
// app/Http/Controllers/Auth/SocialController.php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class SocialController extends Controller
{
    public function redirect(string $provider)
    {
        if ($provider === 'vkontakte') {
            return Socialite::driver('vkontakte')->scopes(['email'])->redirect();
        }
        return Socialite::driver($provider)->redirect();
    }

    public function callback(string $provider)
    {
        $social = Socialite::driver($provider)->stateless()->user();

        $providerId = $social->getId();
        $email      = $social->getEmail(); // у VK может быть null
        $name       = $social->getName() ?: ($social->getNickname() ?: 'User_'.Str::random(6));

        // ищем по связке провайдера или по email
        $user = User::whereJsonContains('oauth', [$provider => $providerId])->first()
             ?? ($email ? User::where('email', $email)->first() : null);

        DB::transaction(function () use (&$user, $provider, $providerId, $email, $name) {
            if (!$user) {
                $user = User::create([
                    'name'              => $name,
                    'email'             => $email ?: strtolower($provider).'_'.$providerId.'@example.local',
                    'password'          => bcrypt(Str::random(32)),
                    'email_verified_at' => now(), // если доверяешь провайдеру
                    'oauth'             => [$provider => $providerId], // json колонка
                ]);
            } else {
                $oauth = $user->oauth ?? [];
                $oauth[$provider] = $providerId;
                $user->oauth = $oauth;
                $user->save();
            }
        });

        Auth::login($user, remember: true);

        return redirect()->intended(route('dashboard'));
    }
}
