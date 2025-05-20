<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Deal;
use App\Models\User;
use App\Models\Offer;

class DealSeeder extends Seeder
{
    public function run(): void
    {
        Deal::factory()->count(5)->create();
    }
}


