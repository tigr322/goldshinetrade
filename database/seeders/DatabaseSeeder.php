<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        $this->call([
           
          
            OfferSeeder::class,
            DealSeeder::class,
           CategorySeeder::class,
           GameSeeder::class,
           GameCategorySeeder::class,
            ServerSeeder::class,
            PaymentMethodSeeder::class,
            WithdrawalSeeder::class,
            MessageSeeder::class,
        ]);
    }
}
