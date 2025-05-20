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
class DealFactory extends Factory
{
    protected $model = \App\Models\Deal::class;

    public function definition(): array
    {
        return [
            'offer_id' => Offer::factory(),
            'buyer_id' => \App\Models\User::factory(),
            'payment_method_id' => PaymentMethod::factory(),
            'quantity' => $this->faker->numberBetween(1, 5),
            'total_price' => $this->faker->randomFloat(2, 100, 2000),
            'status' => $this->faker->randomElement(['pending', 'paid', 'completed']),
            'funds_frozen' => true,
        ];
    }
}
