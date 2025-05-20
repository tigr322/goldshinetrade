<?php

namespace Database\Factories;

use App\Models\Category;
use App\Models\Game;
use App\Models\Server;
use App\Models\PaymentMethod;
use App\Models\Offer;
use App\Models\Deal;
use App\Models\Withdrawal;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;


 class ServerFactory extends Factory
 {
    protected $model = Server::class;
 
     public function definition(): array
     {
         return [
             'name' => $this->faker->unique()->word(),
             'game_id' => Game::factory(),
         ];
     }
 }