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
        Offer::factory()->count(5)->create();
    }
}
