<?php

use Illuminate\Support\Facades\Broadcast;
use App\Models\Deal;

Broadcast::channel('deal.{dealId}', function ($user, $dealId) {
    $deal = \App\Models\Deal::with('offer')->find($dealId);
    return $deal && ($user->id === $deal->buyer_id || $user->id === $deal->offer->user_id);
});