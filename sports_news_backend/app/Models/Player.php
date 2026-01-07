<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Player extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'position',
        'jersey_number',
        'nationality',
        'image_emoji',
        'flag_emoji',
        'team_id',
        'sport_id',
    ];

    protected $casts = [
        'jersey_number' => 'integer',
    ];

    public function team()
    {
        return $this->belongsTo(Team::class);
    }

    public function sport()
    {
        return $this->belongsTo(Sport::class);
    }

    public function users()
    {
        return $this->belongsToMany(User::class, 'user_players');
    }
}
