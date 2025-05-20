<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Withdrawal;
use App\Models\User;

class WithdrawalSeeder extends Seeder
{
    public function run(): void
    {
        $user = User::first();

        Withdrawal::insert([
            [
                'user_id' => $user->id,
                'amount' => 1500.00,
                'method' => 'ЮMoney',
                'details' => '410011223344',
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'user_id' => $user->id,
                'amount' => 2500.00,
                'method' => 'Сбербанк',
                'details' => '5469 1234 5678 9012',
                'status' => 'paid',
                'created_at' => now()->subDays(2),
                'updated_at' => now()->subDays(1),
            ],
        ]);
    }
}
