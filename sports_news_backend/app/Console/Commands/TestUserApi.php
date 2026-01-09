<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use Laravel\Sanctum\Sanctum;

class TestUserApi extends Command
{
    protected $signature = 'test:user-api';
    protected $description = 'Test user API endpoint';

    public function handle()
    {
        $this->info('Testing user API endpoint...');
        
        // Get a user and create a token
        $user = User::first();
        if (!$user) {
            $this->error('No user found');
            return 1;
        }
        
        $this->info("User: {$user->name}");
        
        // Create a token for testing
        $token = $user->createToken('test-token')->plainTextToken;
        $this->info("Token: {$token}");
        
        // Test the user resource directly
        $userWithPrefs = $user->load([
            'preferredSports',
            'preferredLeagues.sport',
            'preferredTeams.league.sport',
            'preferredPlayers.team.sport',
            'assignedSport'
        ]);
        
        $userResource = new \App\Http\Resources\UserResource($userWithPrefs);
        $this->info("User Resource:");
        $this->info(json_encode($userResource->toArray(request()), JSON_PRETTY_PRINT));
        
        return 0;
    }
}
