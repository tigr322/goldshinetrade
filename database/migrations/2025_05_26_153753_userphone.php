<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Добавить поля для 2FA по телефону.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('phone')->nullable()->after('email');
            $table->string('phone_verification_code')->nullable()->after('phone');
            $table->timestamp('phone_verified_at')->nullable()->after('phone_verification_code');
        });
    }

    /**
     * Удалить поля, если миграция откатывается.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['phone', 'phone_verification_code', 'phone_verified_at']);
        });
    }
};