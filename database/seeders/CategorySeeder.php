<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
class CategorySeeder extends Seeder
{
    public function run(): void
    {
        Category::insert([
            ['name' => 'Пополнение Steam'],
            ['name' => 'Внутриигровая валюта'],
            ['name' => 'Прочее'],
        ]);
    }
}