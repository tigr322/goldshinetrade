<?php

namespace App\Http\Controllers;
use App\Models\Deal;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Auth;

class MainController extends Controller
{
    public function index(Request $request)
{
    $user = $request->user();

    // Получаем ID сделок, где пользователь — покупатель или продавец
    $userDeals = Deal::where('buyer_id', $user->id)
        ->orWhereHas('offer', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })
        ->pluck(column: 'id');
    return Inertia::render('Dashboard', [
        'user' => $user,
        'balance' => number_format($user->balance ?? 0, 2, '.', ' '),
        'offers_count' => $user->offers()->count(),
        'deals_count' => $user->deals()->count(),
        'messages_count' => $user->messages()->count(),
        'userDeals' => $userDeals, 

        'withdrawals' => $user->withdrawals()->latest()->take(5)->get()->map(function ($w) {
            return [
                'id' => $w->id,
                'name' => 'Вывод средств (' . ucfirst($w->method) . ')',
                'amount' => number_format($w->amount, 2, '.', ' '),
                'currency' => '₽',
                'status' => $w->status, // можно использовать для бейджей
                'date' => $w->created_at->translatedFormat('d F Y'),
                'datetime' => $w->created_at->toDateString(),
                'href' => '#', // или ссылка на детали, если есть
            ];
        }),
    ]);
}
public function learnmore(Request $request)
{
    return Inertia::render('LearnMore');
}

}
