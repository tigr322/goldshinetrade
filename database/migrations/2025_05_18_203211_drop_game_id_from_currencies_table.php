<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('currencies', function (Blueprint $table) {
            $table->dropForeign(['game_id']); // Удаляем внешний ключ
            $table->dropColumn('game_id');    // Удаляем саму колонку
        });

        Schema::dropIfExists('games'); // Если больше не нужна таблица games
    }

    public function down(): void
    {
        Schema::create('games', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->timestamps();
        });

        Schema::table('currencies', function (Blueprint $table) {
            $table->foreignId('game_id')->nullable()->constrained()->onDelete('cascade');
        });
    }
};
