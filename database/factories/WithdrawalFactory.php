<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\App;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Withdrawal>
 */
class WithdrawalFactory extends Factory
{
    protected $model = \App\Models\Withdrawal::class;

    public function definition(): array
    {
        return [
            'user_id' => \App\Models\User::factory(),
            'amount' => $this->faker->randomFloat(2, 100, 5000),
            'method' => $this->faker->creditCardType(),
            'details' => $this->faker->iban(),
            'status' => $this->faker->randomElement(['pending', 'paid', 'rejected']),
        ];
    }
}
