<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Game;
use App\Models\Category;
use App\Models\GameCategory;

class GameCategorySeeder extends Seeder
{
    public function run(): void
    {
        // Получаем все игры и категории из базы
        $games = Game::all();
        $categories = Category::all();

        // Для каждой игры привязываем случайные категории
        foreach ($games as $game) {
            // Выбираем от 1 до 3 случайных категорий
            $categoryIds = $categories->random(rand(1, 3))->pluck('id');

            foreach ($categoryIds as $categoryId) {
                GameCategory::create([
                    'game_id' => $game->id,
                    'category_id' => $categoryId,
                ]);
            }
        }
    }
}
