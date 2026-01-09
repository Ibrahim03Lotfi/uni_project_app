<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Http\Controllers\UserPreferenceController;

class TestOnboardingFlow extends Command
{
    protected $signature = 'test:onboarding-flow';
    protected $description = 'Test complete onboarding flow';

    public function handle()
    {
        $this->info('Testing complete onboarding flow...');
        
        // Get a test user
        $user = User::first();
        if (!$user) {
            $this->error('No user found');
            return 1;
        }
        
        $this->info("User: {$user->name} (ID: {$user->id})");
        
        // Clear existing preferences for clean test
        $user->preferredSports()->detach();
        $user->preferredLeagues()->detach();
        $user->preferredTeams()->detach();
        $user->preferredPlayers()->detach();
        $this->info('Cleared all existing preferences');
        
        // Test 1: Save sports preferences
        $this->info('1. Testing sports preferences...');
        $sportIds = [1]; // Football
        $controller = new UserPreferenceController();
        
        // Mock request
        $request = new \Illuminate\Http\Request();
        $request->setUserResolver(function() use ($user) { return $user; });
        $request->merge(['sport_ids' => $sportIds]);
        
        try {
            $response = $controller->updateSports($request);
            $this->info('Sports update response status: ' . $response->getStatusCode());
            
            // Check if saved to database
            $savedSports = $user->preferredSports()->count();
            $this->info("Sports saved to DB: $savedSports");
            
        } catch (\Exception $e) {
            $this->error('Sports update failed: ' . $e->getMessage());
        }
        
        // Test 2: Save leagues preferences
        $this->info('2. Testing leagues preferences...');
        $leagueIds = [1]; // Premier League
        $request->merge(['league_ids' => $leagueIds]);
        
        try {
            $response = $controller->updateLeagues($request);
            $this->info('Leagues update response status: ' . $response->getStatusCode());
            
            // Check if saved to database
            $savedLeagues = $user->preferredLeagues()->count();
            $this->info("Leagues saved to DB: $savedLeagues");
            
        } catch (\Exception $e) {
            $this->error('Leagues update failed: ' . $e->getMessage());
        }
        
        // Test 3: Save teams preferences
        $this->info('3. Testing teams preferences...');
        $teamIds = [1]; // Arsenal
        $request->merge(['team_ids' => $teamIds]);
        
        try {
            $response = $controller->updateTeams($request);
            $this->info('Teams update response status: ' . $response->getStatusCode());
            
            // Check if saved to database
            $savedTeams = $user->preferredTeams()->count();
            $this->info("Teams saved to DB: $savedTeams");
            
        } catch (\Exception $e) {
            $this->error('Teams update failed: ' . $e->getMessage());
        }
        
        // Test 4: Save players preferences
        $this->info('4. Testing players preferences...');
        $playerIds = [1]; // Lionel Messi
        $request->merge(['player_ids' => $playerIds]);
        
        try {
            $response = $controller->updatePlayers($request);
            $this->info('Players update response status: ' . $response->getStatusCode());
            
            // Check if saved to database
            $savedPlayers = $user->preferredPlayers()->count();
            $this->info("Players saved to DB: $savedPlayers");
            
        } catch (\Exception $e) {
            $this->error('Players update failed: ' . $e->getMessage());
        }
        
        // Final check
        $this->info('Final database state:');
        $this->info("  Sports: " . $user->preferredSports()->count());
        $this->info("  Leagues: " . $user->preferredLeagues()->count());
        $this->info("  Teams: " . $user->preferredTeams()->count());
        $this->info("  Players: " . $user->preferredPlayers()->count());
        
        return 0;
    }
}
