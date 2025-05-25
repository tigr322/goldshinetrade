<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Game;
use App\Models\GameType;
use App\Models\Server;
use App\Models\PaymentMethod;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AdminDataController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Data/Index', [
            'categories' => Category::all(),
            'games' => Game::with('category', 'gameType')->get(),
            'servers' => Server::with('game')->get(),
            'paymentMethods' => PaymentMethod::all(),
            'gameTypes' => GameType::all(),
        ]);
    }

    public function storeCategory(Request $request)
    {
        $request->validate(['name' => 'required|string|max:255']);
        Category::create($request->only('name'));
        return back()->with('success', 'Категория добавлена.');
    }

    public function updateCategory(Request $request, Category $category)
    {
        $request->validate(['name' => 'required|string|max:255']);
        $category->update($request->only('name'));
        return back()->with('success', 'Категория обновлена.');
    }

    public function destroyCategory(Category $category)
    {
        $category->delete();
        return back()->with('success', 'Категория удалена.');
    }

    public function storeGame(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'game_type_id' => 'nullable|integer'
        ]);
        Game::create($request->only('name', 'category_id', 'game_type_id'));
        return back()->with('success', 'Игра добавлена.');
    }

    public function updateGame(Request $request, Game $game)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'game_type_id' => 'nullable|integer'
        ]);
        $game->update($request->only('name', 'category_id', 'game_type_id'));
        return back()->with('success', 'Игра обновлена.');
    }

    public function destroyGame(Game $game)
    {
        $game->delete();
        return back()->with('success', 'Игра удалена.');
    }

    public function storeServer(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'game_id' => 'required|exists:games,id'
        ]);
        Server::create($request->only('name', 'game_id'));
        return back()->with('success', 'Сервер добавлен.');
    }

    public function updateServer(Request $request, Server $server)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'game_id' => 'required|exists:games,id'
        ]);
        $server->update($request->only('name', 'game_id'));
        return back()->with('success', 'Сервер обновлён.');
    }

    public function destroyServer(Server $server)
    {
        $server->delete();
        return back()->with('success', 'Сервер удалён.');
    }

    public function storePaymentMethod(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'details' => 'nullable|string|max:255'
        ]);
        PaymentMethod::create($request->only('name', 'details'));
        return back()->with('success', 'Метод оплаты добавлен.');
    }

    public function updatePaymentMethod(Request $request, PaymentMethod $paymentMethod)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'details' => 'nullable|string|max:255'
        ]);
        $paymentMethod->update($request->only('name', 'details'));
        return back()->with('success', 'Метод оплаты обновлён.');
    }

    public function destroyPaymentMethod(PaymentMethod $paymentMethod)
    {
        $paymentMethod->delete();
        return back()->with('success', 'Метод оплаты удалён.');
    }
}