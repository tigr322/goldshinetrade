<?php

namespace Database\Factories;

use App\Models\Offer;
use App\Models\User;
use App\Models\Category;
use App\Models\Server;
use Illuminate\Database\Eloquent\Factories\Factory;

class OfferFactory extends Factory
{
    protected $model = Offer::class;

    public function definition(): array
    {
        return [
            'user_id' => User::inRandomOrder()->first()?->id ?? User::factory(),
            'category_id' => Category::inRandomOrder()->first()?->id ?? Category::factory(),
            'server_id' => Server::inRandomOrder()->first()?->id ?? Server::factory(),
            'title' => $this->faker->sentence(3),
            'description' => $this->faker->paragraph(),
            'price' => $this->faker->randomFloat(2, 100, 5000),
            'quantity' => $this->faker->numberBetween(1, 100),
            'is_active' => true,
        ];
    }
}
