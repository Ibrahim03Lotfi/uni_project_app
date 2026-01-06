<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NewsArticle extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'content',
        'image_url',
        'category',
        'sport_id',
        'team_id',
        'author_id',
        'tags',
        'published_at'
    ];

    protected $casts = [
        'tags' => 'array',
        'published_at' => 'datetime'
    ];

    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    public function sport()
    {
        return $this->belongsTo(Sport::class);
    }

    public function team()
    {
        return $this->belongsTo(Team::class);
    }

    public function likes()
    {
        return $this->hasMany(ArticleLike::class);
    }
}
