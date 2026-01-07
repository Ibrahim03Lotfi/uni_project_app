<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Team;
use App\Models\Player;

class TestTeamPlayers extends Command
{
    protected $signature = 'test:team-players';
    protected $description = 'Test team-player relationships';

    public function handle()
    {
        $this->info('Testing team-player relationships...');
        
        $teams = Team::take(3)->get();
        
        foreach ($teams as $team) {
            $this->info("Team: {$team->name} (ID: {$team->id})");
            $playerCount = $team->players()->count();
            $this->info("  Players count: {$playerCount}");
            
            if ($playerCount > 0) {
                $players = $team->players()->take(3)->get();
                foreach ($players as $player) {
                    $this->info("    - {$player->name}");
                }
            }
            $this->info("");
        }
        
        // Test API endpoint structure
        $team = Team::first();
        $players = $team->players()->with(['sport', 'team'])->get();
        $this->info("API structure test:");
        $this->info(json_encode($players->toArray(), JSON_PRETTY_PRINT));
        
        return 0;
    }
}
