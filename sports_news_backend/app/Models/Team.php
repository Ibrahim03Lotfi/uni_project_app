<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\League;
use App\Models\Player;
use App\Models\Sport;

class Team extends Model
{
    public function league()
    {
        return $this->belongsTo(League::class);
    }
    
    public function players()
    {
        return $this->hasMany(Player::class);
    }
    
    public function sport()
    {
        return $this->belongsTo(Sport::class);
    }
}
