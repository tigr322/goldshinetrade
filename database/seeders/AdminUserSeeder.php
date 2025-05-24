<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class AdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        Role::firstOrCreate(['name' => 'admin']);
        $admin = \App\Models\User::firstOrCreate(
            ['email' => 'tigran05012002@mail.ru'],
            ['name' => 'Tigran Adamyan', 'password' => bcrypt('Pow20032005.')]
        );
    
        $admin->assignRole('admin');
    }
}
