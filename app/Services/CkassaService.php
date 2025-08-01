<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use App\Models\Payment;

class CkassaService
{
    public static function generateExternalId(): string
{
    do {
        $id = str_pad(random_int(0, 999999999999), 12, '0', STR_PAD_LEFT);
    } while (Payment::where('external_id', $id)->exists());

    return $id;
}
    public static function createInvoice(int $amount, int $userId): ?string
    {
        $externalId = self::generateExternalId();
        $encryptedId = \App\Services\EncryptionService::encryptExternalId($externalId);
        $payload = [
            'servCode' => config('ckassa.serv_code'),
            'startPaySelect' => 'false',
            'invType' => 'READ_ONLY',
            'amount' => strval($amount*100),
            'properties' => [
                7900000000,  
                $encryptedId,
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
           
           

            if ($response->successful() && filter_var($response->body(), FILTER_VALIDATE_URL)) {
                $url = trim($response->body());
                Log::info('📤 Creating payment record', [
                    'user_id' => $userId,
                    'invoice_url' => $url,
                    'amount' => $amount,
                    'status' => 'CREATED',
                    'external_id' => $externalId,
                ]);
                try {
                    $payment = Payment::create([
                        'user_id' => $userId,
                        'invoice_url' => $url,
                        'amount' => $amount,
                        'status' => 'CREATED',
                        'external_id' => $externalId,
                    ]);
                
                } catch (\Exception $e) {
                    Log::error('❌ Payment not saved', [
                        'message' => $e->getMessage(),
                        'trace' => $e->getTraceAsString(),
                    ]);
                }

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
