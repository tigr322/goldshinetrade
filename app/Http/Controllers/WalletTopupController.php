<?php

namespace App\Http\Controllers;
use App\Models\UserCard;
use Inertia\Inertia;
use Illuminate\Support\Facades\Log;

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
    $user = Auth::id();

    $url = CkassaService::createInvoice($request->amount, $user);

    if ($url) {
        return Inertia::location($url);    }

    return response()->json(['error' => 'Не удалось создать счёт'], 400);
}
public function handleCallback(Request $request)
{
    $externalId = data_get($request->input('property'), 'ЛИЦЕВОЙ_СЧЕТ');

    if (!$externalId) {
        return response()->json(['error' => 'Missing external ID'], 400);
    }
    $response = Http::withHeaders([
        'ApiLoginAuthorization' => config('ckassa.shop_token'),
        'ApiAuthorization' => config('ckassa.secret_key'),
        'Content-Type' => 'application/json',
        'User-Agent' => 'MyCustomAgent/1.0',
    ])->timeout(60)->post(config('ckassa.url'), [
        'regPayNum' => $request->input('regPayNum'), 
    ]);
    
    $checkData = $response->json();
    
    if (!$response->successful() || !isset($checkData['state']) || $checkData['state'] !== 'PAYED') {
        return response()->json(['error' => 'Payment not confirmed by CKassa'], 400);
    }
    
    $payment = \App\Models\Payment::where('external_id', $externalId)->first();

    if (!$payment) {
        return response()->json(['error' => 'Payment not found'], 404);
    }

    $state = $request->input('state');
    $code = data_get($request->input('result'), 'code');
    $amount = (float) $request->input('amount') / 100;

    if ($state !== 'PAYED' || $code !== 0) {
        return response()->json(['error' => 'Payment not completed'], 400);
    }

    if ($payment->status === 'PAID') {
        return response()->json(['message' => 'Already processed'], 200);
    }

    DB::transaction(function () use ($payment, $amount) {
        $user = $payment->user;
        $user->balance += $amount;
        $user->save();

        $payment->status = 'PAID';
        $payment->save();
    });
 //event(new BalanceUpdated($userId, $user->balance));
    return response()->json(['status' => 'ok']);
}
}
