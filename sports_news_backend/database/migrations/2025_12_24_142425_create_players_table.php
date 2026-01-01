<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('players', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('nationality');
            $table->string('position');
            $table->string('jersey_number')->nullable();
            $table->string('image_emoji')->nullable();
            $table->string('flag_emoji')->nullable();
            $table->boolean('is_featured')->default(false);
            $table->foreignId('team_id')->constrained();
            $table->foreignId('sport_id')->constrained();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('players');
    }
};