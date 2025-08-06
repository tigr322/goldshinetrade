<?php

namespace App\Http\Controllers;
use App\Models\Deal;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
class MainController extends Controller
{
    public function index(Request $request)
{
    $user = $request->user();
    $withdrawals = $user->withdrawals()->latest()->paginate(5);
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

      'withdrawals' => $withdrawals->map(function ($w) {
        return [
            'id' => $w->id,
            'name' => 'Вывод средств (' . ucfirst($w->method) . ')',
            'amount' => number_format($w->amount, 2, '.', ' '),
            'currency' => '₽',
            'status' => $w->status,
            'date' => $w->created_at->translatedFormat('d F Y'),
            'datetime' => $w->created_at->toDateString(),
            'href' => '#',
        ];
    }),
    'withdrawalsPagination' => [
        'from' => $withdrawals->firstItem(),
        'to' => $withdrawals->lastItem(),
        'total' => $withdrawals->total(),
        'current_page' => $withdrawals->currentPage(),
        'last_page' => $withdrawals->lastPage(),
        'per_page' => $withdrawals->perPage(),
    ],
    ]);
}
public function learnmore(Request $request)
{
    return Inertia::render('LearnMore');
}

public function show(User $user)
{
    return inertia('Users/Show', [
        'user' => $user->only(['id', 'name', 'email', 'photo', 'balance', 'rating', 'adress']),
        'offers' => $user->offers()->latest()->get(['id', 'title', 'description', 'price']),
        'reviews' => $user->reviewsReceived()->latest()->with('fromUser:id,name')->get(),
    ]);
}

}
