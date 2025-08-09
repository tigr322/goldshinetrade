<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;


return new class {
    public function up() {
        Schema::table('users', function (Blueprint $t) {
            $t->json('oauth')->nullable();
        });
    }
    public function down() {
        Schema::table('users', function (Blueprint $t) {
            $t->dropColumn('oauth');
        });
    }
};
