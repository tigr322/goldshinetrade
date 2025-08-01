<?php
namespace App\Services;

use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Log;

class EncryptionService
{
    public static function encryptExternalId(string $plaintext): string
    {
        return Crypt::encryptString($plaintext);
    }

    public static function decryptExternalId(string $ciphertext): ?string
    {
        try {
            return Crypt::decryptString($ciphertext);
        } catch (\Exception $e) {
            Log::error('❌ Ошибка расшифровки external_id', ['error' => $e->getMessage()]);
            return null;
        }
    }
}