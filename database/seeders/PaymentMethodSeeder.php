<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\PaymentMethod;
class PaymentMethodSeeder extends Seeder
{
    public function run(): void
    {
        PaymentMethod::insert([
            ['name' => 'ЮMoney', 'details' => '...'],
            ['name' => 'Карта Сбер', 'details' => '...'],
            ['name' => 'QIWI', 'details' => '...'],
        ]);
    }
}
