<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Models\Sport;

class TestAddPreference extends Command
{
    protected $signature = 'test:add-preference';
    protected $description = 'Add a test preference';

    public function handle()
    {
        $this->info('Adding test preference...');
        
        $user = User::first();
        $football = Sport::find(1);
        
        if ($user && $football) {
            $this->info("User: {$user->name}, Sport: {$football->name}");
            
            // Check if already following
            $isFollowing = $user->preferredSports()->where('sport_id', 1)->exists();
            $this->info("Already following: " . ($isFollowing ? 'Yes' : 'No'));
            
            if (!$isFollowing) {
                $user->preferredSports()->attach(1);
                $this->info("Attached sport to user");
            }
            
            // Check again
            $newCount = $user->preferredSports()->count();
            $this->info("New preferred sports count: " . $newCount);
            
            // Test the API response structure
            $userWithPrefs = $user->load(['preferredSports']);
            $this->info("User with preferences:");
            $this->info(json_encode($userWithPrefs->toArray(), JSON_PRETTY_PRINT));
            
        } else {
            $this->error('User or sport not found');
        }
        
        return 0;
    }
}
