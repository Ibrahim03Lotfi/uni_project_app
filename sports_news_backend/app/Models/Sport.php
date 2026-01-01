<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sport extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'icon', 'color', 'description', 'emoji'
    ];

    public function users()
    {
        return $this->belongsToMany(User::class, 'user_sports');
    }

    public function teams()
    {
        return $this->hasMany(Team::class);
    }

    public function leagues()
    {
        return $this->hasMany(League::class);
    }

    public function players()
    {
        return $this->hasMany(Player::class);
    }
}