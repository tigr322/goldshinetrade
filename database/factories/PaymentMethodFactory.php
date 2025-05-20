<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\App;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\PaymentMethod>
 */
class PaymentMethodFactory extends Factory
{
    protected $model = \App\Models\PaymentMethod::class;

    public function definition(): array
    {
        return [
            'name' => $this->faker->creditCardType(),
            'details' => $this->faker->iban(),
        ];
    }
}