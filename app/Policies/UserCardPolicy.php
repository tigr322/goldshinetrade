<?php

namespace App\Policies;

use App\Models\User;
use App\Models\UserCard;

class UserCardPolicy
{
    public function viewAny(User $user): bool
    {
        return true;
    }

    public function view(User $user, UserCard $card): bool
    {
        return $user->id === $card->user_id;
    }

    public function create(User $user): bool
    {
        return true;
    }

    public function update(User $user, UserCard $card): bool
    {
        return $user->id === $card->user_id;
    }

    public function delete(User $user, UserCard $card): bool
    {
        return $card->user_id === $user->id;
    }
}