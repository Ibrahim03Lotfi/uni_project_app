<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('matches', function (Blueprint $table) {
            $table->id();
            $table->foreignId('home_team_id')->constrained('teams');
            $table->foreignId('away_team_id')->constrained('teams');
            $table->foreignId('league_id')->constrained();
            $table->foreignId('sport_id')->constrained();
            $table->dateTime('match_time');
            $table->enum('status', ['scheduled', 'live', 'finished'])->default('scheduled');
            $table->integer('home_score')->nullable();
            $table->integer('away_score')->nullable();
            $table->string('live_minute')->nullable();
            $table->timestamps();
            
            // Indexes for better query performance
            $table->index(['status', 'match_time']);
            $table->index('league_id');
            $table->index('sport_id');
        });
    }

    public function down()
    {
        Schema::dropIfExists('matches');
    }
};