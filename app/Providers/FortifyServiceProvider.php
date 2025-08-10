<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Laravel\Fortify\Fortify;
use Inertia\Inertia;

class FortifyServiceProvider extends ServiceProvider
{
    public function register(): void {}

    public function boot(): void
    {
        // Экран двухфакторного челленджа
        Fortify::twoFactorChallengeView(function () {
            return Inertia::render('Auth/TwoFactorChallenge'); // твоя Vue-страница
        });

        // При желании: Fortify::loginView(...), Fortify::registerView(...)
    }
}
