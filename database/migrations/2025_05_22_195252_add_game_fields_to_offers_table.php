<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   // database/migrations/xxxx_xx_xx_xxxxxx_add_game_fields_to_offers_table.php
public function up()
{
    Schema::table('offers', function (Blueprint $table) {
        $table->foreignId('game_category_id')->nullable()->constrained('game_category')->onDelete('set null');
        $table->foreignId('game_id')->nullable()->constrained()->onDelete('set null');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('offers', function (Blueprint $table) {
            //
        });
    }
};
