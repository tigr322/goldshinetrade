<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Game;
class GameSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
   
            public function run(): void
            {
                Game::insert([
                    ['name' => 'World of Warcraft'],
                    ['name' => 'Diablo IV'],
                    ['name' => 'Counter-Strike 2'],
                ]);
            }
       
}
