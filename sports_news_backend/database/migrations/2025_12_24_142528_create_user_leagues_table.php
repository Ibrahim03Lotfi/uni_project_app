<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('user_leagues', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('league_id')->constrained();
            $table->timestamps();
            
            $table->unique(['user_id', 'league_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('user_leagues');
    }
};