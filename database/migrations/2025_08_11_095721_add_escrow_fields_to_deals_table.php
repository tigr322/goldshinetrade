<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('deals', function (Blueprint $table) {
            $table->decimal('escrow_amount', 12, 2)->default(0); // сколько заморожено
            $table->timestamp('confirmed_at')->nullable();       // подтверждение покупателя
            $table->timestamp('released_at')->nullable();        // когда выплачено продавцу
            $table->timestamp('canceled_at')->nullable();        // если отмена
           
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('deals', function (Blueprint $table) {
            //
        });
    }
};
