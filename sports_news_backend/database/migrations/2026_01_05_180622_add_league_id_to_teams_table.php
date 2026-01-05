<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::table('teams', function (Blueprint $table) {
        $table->foreignId('league_id')->nullable()->after('sport_id')
              ->constrained()->nullOnDelete();
    });
}

public function down()
{
    Schema::table('teams', function (Blueprint $table) {
        $table->dropForeign(['league_id']);
        $table->dropColumn('league_id');
    });
}
};
