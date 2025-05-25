<?php

namespace App\Http\Controllers\Admin;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
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
        $request->validate([
            'role' => 'required|string'
        ]);

        $user->syncRoles([$request->role]); // Spatie Laravel Permission
        return back()->with('success', 'Роль обновлена.');
    }
}
