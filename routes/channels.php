<?php


use App\Models\Deal;
use Illuminate\Support\Facades\Broadcast;

Broadcast::routes(attributes: ['middleware' => ['web', 'auth:sanctum']]);
Broadcast::channel('deal.{id}', function ($user, $id) {
    $deal = Deal::find($id);

    if (!$deal) {
        return false;
    }

    // Пользователь — либо покупатель, либо продавец, но не оба сразу
    $isBuyer = $deal->buyer_id === $user->id;
    $isSeller = $deal->offer->user_id === $user->id;

    return $isBuyer && !$isSeller || $isSeller && !$isBuyer;
}, ['guards' => ['web']]);