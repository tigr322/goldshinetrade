<?php

namespace App\Http\Controllers\Admin;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;

class AdminUsersController extends Controller
{
    public function index()
    {
        $users = User::with('roles')->get(); // если используешь Spatie
        return inertia('Admin/Index', [
            'users' => $users
        ]);
    }
   
    public function updateRole(Request $request, User $user)
    {
        $validated = $request->validate([
            'role' => 'required|string'
        ]);
    
        // Найти или создать роль, если она не существует
        $role = Role::findOrCreate($validated['role']);
    
        // Назначить роль пользователю
        $user->syncRoles([$role]);
    
        return back()->with('success', 'Роль обновлена.');
    }
}
