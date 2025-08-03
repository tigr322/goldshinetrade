<?php

namespace App\Providers;

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\Admin;
use App\Http\Middleware\AdminOrModer;
use App\Http\Middleware\Moder;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\UserCard;
use App\Http\Middleware\VerifyCsrfToken;
use Illuminate\Auth\Notifications\VerifyEmail;
use Illuminate\Notifications\Messages\MailMessage;
class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        VerifyEmail::toMailUsing(function (object $notifiable, string $url) {
            return (new MailMessage)
                ->subject('Verify Email Address')
                ->line('Click the button below to verify your email address.')
                ->action('Verify Email Address', $url);
        });
        Route::aliasMiddleware('csrf', VerifyCsrfToken::class);
        Route::model('card', UserCard::class);
        Vite::prefetch(concurrency: 3);
        Route::aliasMiddleware('admin', Admin::class);
        Route::aliasMiddleware('moder', Moder::class);
        Route::aliasMiddleware('admin_or_moder', AdminOrModer::class);
        Inertia::share([
            'auth' => fn () => [
                'user' => Auth::check() ? [
                    'id' => Auth::id(),
                    'name' => Auth::user()->name,
                   'roles' => Auth::user()->getRoleNames(), 
                ] : null,
            ],
        ]);
    }
}
