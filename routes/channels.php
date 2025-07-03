<?php


use App\Models\Deal;
use Illuminate\Support\Facades\Broadcast;

Broadcast::routes(attributes: ['middleware' => ['web', 'auth:sanctum']]);
Broadcast::channel('deal.{id}', function ($user, $id) {
   
    return true;
}, ['guards' => ['web']]);