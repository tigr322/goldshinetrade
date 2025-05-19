<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Currency;

class CategoryAndCurrencySeeder extends Seeder
{
    public function run(): void
    {
        // Примеры категорий
        $categories = [
            ['name' => 'MMORPG', 'slug' => 'mmorpg', 'description' => 'Massively Multiplayer Online RPG'],
            ['name' => 'FPS', 'slug' => 'fps', 'description' => 'First Person Shooters'],
            ['name' => 'MOBA', 'slug' => 'moba', 'description' => 'Multiplayer Online Battle Arena'],
        ];

        foreach ($categories as $data) {
            Category::create($data);
        }

        // Примеры валют
        $currencies = [
            ['name' => 'Gold'],
            ['name' => 'Credits'],
            ['name' => 'Diamonds'],
        ];

        foreach ($currencies as $data) {
            Currency::create($data);
        }
    }
}
