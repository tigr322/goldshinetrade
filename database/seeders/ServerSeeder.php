<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Server;
class ServerSeeder extends Seeder
{
    public function run(): void
    {
        Server::insert([
            ['name' => 'Warmane', 'game_id' => 1],
            ['name' => 'Icecrown', 'game_id' => 1],
        ]);
    }
}