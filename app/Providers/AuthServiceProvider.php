<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
use App\Models\UserCard;
use App\Policies\UserCardPolicy;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * Карта политик приложения.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        UserCard::class => UserCardPolicy::class,
    ];

    /**
     * Регистрация любых служб авторизации.
     */
    public function boot(): void
    {
        $this->registerPolicies();
    }
}