<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::create([
            'name' => 'Admin',
            'email' => 'admin@example.com',
            'password' => Hash::make('password'),
            'phone' => '1234567890',
            'is_verified' => true,
            'balance_real' => 1000.00,
            'rating' => 4.5,
        ]);

        User::factory(10)->create(); // Генерация 10 тестовых пользователей
    }
}
