<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('article_likes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('article_id')->constrained('news_articles')->onDelete('cascade');
            $table->timestamps();
            
            // One user can like an article only once
            $table->unique(['user_id', 'article_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('article_likes');
    }
};