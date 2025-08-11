<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('offers', function (Blueprint $table) {
            $table->string('fee_model', 20)
                  ->default('buyer_pays')
                  ->after('is_active'); // схема комиссии: buyer_pays | seller_pays | split
            $table->decimal('fee_buyer_percent', 5, 2)
                  ->default(0)
                  ->after('fee_model'); // процент комиссии для покупателя
            $table->decimal('fee_seller_percent', 5, 2)
                  ->default(0)
                  ->after('fee_buyer_percent'); // процент комиссии для продавца
        });
    }

    public function down(): void
    {
        Schema::table('offers', function (Blueprint $table) {
            $table->dropColumn(['fee_model', 'fee_buyer_percent', 'fee_seller_percent']);
        });
    }
};
