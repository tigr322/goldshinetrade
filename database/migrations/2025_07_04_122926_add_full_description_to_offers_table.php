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
    Schema::table('offers', function (Blueprint $table) {
        $table->text('full_description')->nullable()->after('description'); // или after другого поля
    });
}

public function down(): void
{
    Schema::table('offers', function (Blueprint $table) {
        $table->dropColumn('full_description');
    });
}
};
