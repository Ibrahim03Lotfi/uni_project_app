<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'phone',
        'bio',
        'profile_image',
        'password',
        'is_admin',
        'is_super_admin',
        'settings',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'settings' => 'array',
        'is_admin' => 'boolean',
        'is_super_admin' => 'boolean',
    ];

    // Add these to your existing User model:
public function preferredSports()
{
    return $this->belongsToMany(Sport::class, 'user_sports');
}

public function preferredTeams()
{
    return $this->belongsToMany(Team::class, 'user_teams');
}

public function preferredLeagues()
{
    return $this->belongsToMany(League::class, 'user_leagues');
}

public function preferredPlayers()
{
    return $this->belongsToMany(Player::class, 'user_players');
}
}