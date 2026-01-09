<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\League;
use App\Models\Team;

class TestLeagueTeams extends Command
{
    protected $signature = 'test:league-teams';
    protected $description = 'Test league-team relationships';

    public function handle()
    {
        $this->info('Testing league-team relationships...');
        
        $leagues = League::take(3)->get();
        
        foreach ($leagues as $league) {
            $this->info("League: {$league->name} (ID: {$league->id})");
            $teamCount = $league->teams()->count();
            $this->info("  Teams count: {$teamCount}");
            
            if ($teamCount > 0) {
                $teams = $league->teams()->take(3)->get();
                foreach ($teams as $team) {
                    $this->info("    - {$team->name}");
                }
            }
            $this->info("");
        }
        
        return 0;
    }
}
