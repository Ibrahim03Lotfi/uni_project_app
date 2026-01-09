<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Http\Controllers\Api\LeagueController;
use App\Http\Controllers\Api\TeamController;
use App\Http\Controllers\PlayerController;

class TestApiEndpoints extends Command
{
    protected $signature = 'test:api-endpoints';
    protected $description = 'Test API endpoints for recommendations';

    public function handle()
    {
        $this->info('Testing API endpoints...');
        
        // Test LeagueController::all()
        $leagueController = new LeagueController();
        $this->info('Testing LeagueController::all()...');
        
        // Create a mock request
        $request = new \Illuminate\Http\Request();
        
        try {
            $response = $leagueController->all($request);
            $this->info('Leagues API response status: ' . $response->getStatusCode());
            $leaguesData = json_decode($response->getContent(), true);
            $this->info('Leagues count from API: ' . count($leaguesData['data'] ?? []));
        } catch (\Exception $e) {
            $this->error('Leagues API error: ' . $e->getMessage());
        }
        
        // Test TeamController::all()
        $teamController = new TeamController();
        $this->info('Testing TeamController::all()...');
        
        try {
            $response = $teamController->all($request);
            $this->info('Teams API response status: ' . $response->getStatusCode());
            $teamsData = json_decode($response->getContent(), true);
            $this->info('Teams count from API: ' . count($teamsData['data'] ?? []));
        } catch (\Exception $e) {
            $this->error('Teams API error: ' . $e->getMessage());
        }
        
        // Test PlayerController::all()
        $playerController = new PlayerController();
        $this->info('Testing PlayerController::all()...');
        
        try {
            $response = $playerController->all($request);
            $this->info('Players API response status: ' . $response->getStatusCode());
            $playersData = json_decode($response->getContent(), true);
            $this->info('Players count from API: ' . count($playersData['data'] ?? []));
        } catch (\Exception $e) {
            $this->error('Players API error: ' . $e->getMessage());
        }
        
        return 0;
    }
}
