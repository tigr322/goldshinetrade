<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Withdrawal;
use App\Models\User;

class WithdrawalSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();

        foreach ($users as $user) {
            Withdrawal::create([
                'user_id' => $user->id,
                'amount' => rand(100, 1000),
                'method' => 'PayPal',
                'details' => 'PayPal ID: user@example.com',
                'status' => 'paid',
            ]);
        }
    }
}
