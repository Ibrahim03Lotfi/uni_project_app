<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('news_articles', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description');
            $table->text('content');
            $table->string('image_url');
            $table->string('category');
            $table->foreignId('sport_id')->constrained();
            $table->foreignId('author_id')->constrained('users');
            $table->json('tags')->nullable();
            $table->timestamps();
            $table->timestamp('published_at')->nullable();
            
            // Index for faster filtering
            $table->index(['category', 'published_at']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('news_articles');
    }
};