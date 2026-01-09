<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;

class TestUserPreferences extends Command
{
    protected $signature = 'test:user-prefs';
    protected $description = 'Test user preferences in database';

    public function handle()
    {
        $this->info('Testing user preferences in database...');
        
        $user = User::first();
        if (!$user) {
            $this->error('No user found');
            return 1;
        }
        
        $this->info("User: {$user->name} (ID: {$user->id})");
        
        // Check each preference table directly
        $sportsCount = \DB::table('user_sports')->where('user_id', $user->id)->count();
        $leaguesCount = \DB::table('user_leagues')->where('user_id', $user->id)->count();
        $teamsCount = \DB::table('user_teams')->where('user_id', $user->id)->count();
        $playersCount = \DB::table('user_players')->where('user_id', $user->id)->count();
        
        $this->info("Direct DB counts:");
        $this->info("  Sports: $sportsCount");
        $this->info("  Leagues: $leaguesCount");
        $this->info("  Teams: $teamsCount");
        $this->info("  Players: $playersCount");
        
        // Check via relationships
        $this->info("Via relationships:");
        $this->info("  Preferred sports: " . $user->preferredSports()->count());
        $this->info("  Preferred leagues: " . $user->preferredLeagues()->count());
        $this->info("  Preferred teams: " . $user->preferredTeams()->count());
        $this->info("  Preferred players: " . $user->preferredPlayers()->count());
        
        // Show actual data
        if ($leaguesCount > 0) {
            $leagues = $user->preferredLeagues()->get();
            $this->info("Leagues data:");
            foreach ($leagues as $league) {
                $this->info("  - {$league->name} (ID: {$league->id})");
            }
        }
        
        if ($playersCount > 0) {
            $players = $user->preferredPlayers()->get();
            $this->info("Players data:");
            foreach ($players as $player) {
                $this->info("  - {$player->name} (ID: {$player->id})");
            }
        }
        
        return 0;
    }
}
