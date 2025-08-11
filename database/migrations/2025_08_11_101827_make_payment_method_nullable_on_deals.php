<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('deals', function (Blueprint $table) {
            // 1) снять старый FK
            $table->dropForeign(['payment_method_id']);
        });

        // 2) сделать колонку nullable (если нет doctrine/dbal — используем raw SQL)
        try {
            Schema::table('deals', function (Blueprint $table) {
                $table->unsignedBigInteger('payment_method_id')->nullable()->change();
            });
        } catch (\Throwable $e) {
            // fallback без doctrine/dbal
            DB::statement('ALTER TABLE deals MODIFY payment_method_id BIGINT UNSIGNED NULL');
        }

        Schema::table('deals', function (Blueprint $table) {
            // 3) (опционально) вернуть FK, но с nullOnDelete
            $table->foreign('payment_method_id')
                  ->references('id')->on('payment_methods')
                  ->nullOnDelete(); // при удалении метода оплаты -> NULL
        });
    }

    public function down(): void
    {
        Schema::table('deals', function (Blueprint $table) {
            $table->dropForeign(['payment_method_id']);
        });

        // вернуть NOT NULL (если нужно)
        try {
            Schema::table('deals', function (Blueprint $table) {
                $table->unsignedBigInteger('payment_method_id')->nullable(false)->change();
            });
        } catch (\Throwable $e) {
            DB::statement('ALTER TABLE deals MODIFY payment_method_id BIGINT UNSIGNED NOT NULL');
        }

        Schema::table('deals', function (Blueprint $table) {
            $table->foreign('payment_method_id')
                  ->references('id')->on('payment_methods')
                  ->onDelete('cascade');
        });
    }
};
