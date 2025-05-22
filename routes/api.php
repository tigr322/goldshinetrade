<?php 

use Illuminate\Support\Facades\Route;
use App\Models\Game;

Route::get('/servers/by-game/{game}', function (Game $game) {
    return response()->json(
        $game->servers()->select('id', 'name')->get()
    );
});