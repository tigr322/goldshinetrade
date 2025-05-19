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
        $offers = Offer::all();
        $buyers = User::all();

        foreach ($offers as $offer) {
            $buyer = $buyers->random();

            Deal::create([
                'buyer_id' => $buyer->id,
                'offer_id' => $offer->id,
                'quantity' => rand(1, $offer->quantity),
                'total_price' => $offer->price_per_unit * rand(1, $offer->quantity),
                'status' => 'completed',
            ]);
        }
    }
}
