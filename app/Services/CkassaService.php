<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use App\Models\Payment;

class CkassaService
{
    public static function createInvoice(int $amount, int $userId): ?string
    {
        $payload = [
            'servCode' => config('ckassa.serv_code'),
            'startPaySelect' => 'false',
            'invType' => 'AMOUNT_READ_ONLY',
            'amount' => strval($amount*100),
            'properties' => [
                '9180000000',        
            ],
        ];
        Log::info('CKassa payload', $payload);
        try {
            $response = Http::withHeaders([
                'ApiLoginAuthorization' => config('ckassa.shop_token'),
                'ApiAuthorization' => config('ckassa.secret_key'),
                'Content-Type' => 'application/json',
                'User-Agent' => 'MyCustomAgent/1.0',
            ])->timeout(60)->post(
                config('ckassa.url'),
                $payload
            );

            Log::info('CKassa createInvoice response', [
                'status' => $response->status(),
                'body' => $response->body()
            ]);

            if ($response->successful() && filter_var($response->body(), FILTER_VALIDATE_URL)) {
                $url = trim($response->body());

                Payment::create([
                    'user_id' => $userId,
                    'invoice_url' => $url,
                    'amount' => $amount,
                    'status' => 'CREATED',
                ]);

                return $url;
            }
        } catch (\Exception $e) {
            Log::error('CKassa error', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
        }

        return null;
    }
}
