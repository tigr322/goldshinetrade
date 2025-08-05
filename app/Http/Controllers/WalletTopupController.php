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
use App\Services\EncryptionService;

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
    Log::info('🟡 WalletTopupController@store called', $request->all());
    $user = Auth::id();

    $url = CkassaService::createInvoice($request->amount, $user);

    if ($url) {
        return Inertia::location($url);    }

    return response()->json(['error' => 'Не удалось создать счёт'], 400);
}
public function handleCallback(Request $request)
{
    Log::info('CKassa Callback Received', $request->all());

    // Получаем зашифрованный ID из коллбэка
    $encryptedId = data_get($request->input('property'), 'ID');

    if (!$encryptedId) {
        return response()->json(['error' => 'Missing encrypted ID'], 400);
    }

    // Пытаемся расшифровать
    try {
        $externalId = EncryptionService::decryptExternalId($encryptedId);
    } catch (\Exception $e) {
        Log::error('❌ Не удалось расшифровать ID', [
            'encrypted' => $encryptedId,
            'message' => $e->getMessage(),
        ]);

        return response()->json(['error' => 'Invalid external ID'], 400);
    }

    // Ищем платеж
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

    return response()->json(['status' => 'ok']);
}
}
