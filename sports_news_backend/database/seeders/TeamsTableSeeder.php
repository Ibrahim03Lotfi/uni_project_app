<?php

namespace Database\Seeders;

use App\Models\League;
use App\Models\Team;
use Illuminate\Database\Seeder;

class TeamsTableSeeder extends Seeder
{
    public function run()
    {
        $premierLeague = League::where('name', 'Premier League')->first();
        $laLiga = League::where('name', 'La Liga')->first();
        $nba = League::where('name', 'NBA')->first();

        $teams = [
            // Premier League Teams
            [
                'name' => 'Arsenal',
                'league_id' => $premierLeague->id,
                'sport_id' => $premierLeague->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'England',
                'city' => 'London',
                'venue' => 'Emirates Stadium',
                'founded' => 1886,
            ],
            [
                'name' => 'Manchester United',
                'league_id' => $premierLeague->id,
                'sport_id' => $premierLeague->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'England',
                'city' => 'Manchester',
                'venue' => 'Old Trafford',
                'founded' => 1878,
            ],
            // La Liga Teams
            [
                'name' => 'Real Madrid',
                'league_id' => $laLiga->id,
                'sport_id' => $laLiga->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Spain',
                'city' => 'Madrid',
                'venue' => 'Santiago Bernabéu',
                'founded' => 1902,
            ],
            // NBA Teams
            [
                'name' => 'Los Angeles Lakers',
                'league_id' => $nba->id,
                'sport_id' => $nba->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'USA',
                'city' => 'Los Angeles',
                'venue' => 'Crypto.com Arena',
                'founded' => 1947,
            ],
        ];

        foreach ($teams as $team) {
            Team::firstOrCreate(
                ['name' => $team['name'], 'league_id' => $team['league_id']],
                $team
            );
        }
    }
}