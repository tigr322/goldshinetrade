<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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
        'card_id' => 'required|exists:user_cards,id',
    ]);

   
////ввыв
    /** @var \App\Models\User $user */
    $user = Auth::user();
    $user->increment('balance', $request->amount);
    return redirect()->route('dashboard')->with('success', 'Баланс пополнен!');
}
}
