<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Review;
use App\Models\Deal;
use App\Models\User;

class ReviewSeeder extends Seeder
{
    public function run(): void
    {
        $deals = Deal::all();

        foreach ($deals as $deal) {
            Review::create([
                'deal_id' => $deal->id,
                'from_user_id' => $deal->buyer_id,
                'to_user_id' => $deal->offer->user_id,
                'rating' => rand(1, 5),
                'comment' => "Great deal! Rating: " . rand(1, 5),
            ]);
        }
    }
}
