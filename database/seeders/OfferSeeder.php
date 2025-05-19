<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Offer;
use App\Models\User;
use App\Models\Currency;

class OfferSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();
        $currencies = Currency::all();

        foreach ($users as $user) {
            foreach ($currencies as $currency) {
                Offer::create([
                    'user_id' => $user->id,
                    'currency_id' => $currency->id,
                    'title' => "{$currency->name} Offer from {$user->name}",
                    'description' => "Buy {$currency->name} from {$user->name} at the best rates.",
                    'price_per_unit' => rand(10, 100),
                    'quantity' => rand(1, 50),
                    'is_active' => true,
                ]);
            }
        }
    }
}
