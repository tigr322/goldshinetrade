<?php

namespace App\Http\Controllers;
use App\Models\UserCard;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use App\Services\CkassaService;

class WalletTopupController extends Controller
{
    public function create()
{
    $cards = Auth::user()->cards()->get(['id', 'name', 'type', 'number', 'expiry', 'primary']);

    return inertia('Wallet/Create', [
        'cards' => $cards,
    ]);
}
public function store(Request $request)
{
    $request->validate([
        'amount' => 'required|numeric|min:1',
    ]);

    $user = Auth::user()->id;

    // Получаем карту
    $url = CkassaService::createInvoice($request->amount, $user);

    if ($url) {
        return redirect($url); // Перенаправление на оплату
    }

    return back()->with('error', 'Не удалось создать счёт для оплаты');
}
public function handleCallback(Request $request)
{
    $payload = $request->all();

    $signature = $request->header('X-Signature');
    $expected = hash_hmac('sha256', json_encode($payload, JSON_UNESCAPED_UNICODE), config('ckassa.secret'));

    if (!hash_equals($expected, $signature)) {
      
        return response()->json(['error' => 'Invalid signature'], 403);
    }

    $userId = data_get($payload, 'data.user_id');
    $amount = (float) data_get($payload, 'amount');

    $user = \App\Models\User::find($userId);
    if (!$user) return response()->json(['error' => 'User not found'], 404);

    // ✅ Создаём запись в таблице payments и увеличиваем баланс
    DB::transaction(function () use ($user, $amount, $payload) {
        $user->balance += $amount;
        $user->save();

    });

    return response()->json(['status' => 'ok']);
}
}
