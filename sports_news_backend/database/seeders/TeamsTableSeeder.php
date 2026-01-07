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
        $atpTour = League::where('name', 'ATP Tour')->first();
        $fivbTour = League::where('name', 'FIVB World Tour')->first();

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
            [
                'name' => 'Liverpool',
                'league_id' => $premierLeague->id,
                'sport_id' => $premierLeague->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'England',
                'city' => 'Liverpool',
                'venue' => 'Anfield',
                'founded' => 1892,
            ],
            [
                'name' => 'Chelsea',
                'league_id' => $premierLeague->id,
                'sport_id' => $premierLeague->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'England',
                'city' => 'London',
                'venue' => 'Stamford Bridge',
                'founded' => 1905,
            ],
            [
                'name' => 'Manchester City',
                'league_id' => $premierLeague->id,
                'sport_id' => $premierLeague->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'England',
                'city' => 'Manchester',
                'venue' => 'Etihad Stadium',
                'founded' => 1880,
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
            [
                'name' => 'Barcelona',
                'league_id' => $laLiga->id,
                'sport_id' => $laLiga->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Spain',
                'city' => 'Barcelona',
                'venue' => 'Camp Nou',
                'founded' => 1899,
            ],
            [
                'name' => 'Atletico Madrid',
                'league_id' => $laLiga->id,
                'sport_id' => $laLiga->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Spain',
                'city' => 'Madrid',
                'venue' => 'Metropolitano Stadium',
                'founded' => 1903,
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
            [
                'name' => 'Boston Celtics',
                'league_id' => $nba->id,
                'sport_id' => $nba->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'USA',
                'city' => 'Boston',
                'venue' => 'TD Garden',
                'founded' => 1946,
            ],
            [
                'name' => 'Golden State Warriors',
                'league_id' => $nba->id,
                'sport_id' => $nba->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'USA',
                'city' => 'San Francisco',
                'venue' => 'Chase Center',
                'founded' => 1946,
            ],
            [
                'name' => 'Miami Heat',
                'league_id' => $nba->id,
                'sport_id' => $nba->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'USA',
                'city' => 'Miami',
                'venue' => 'FTX Arena',
                'founded' => 1988,
            ],
            // Tennis Players (treated as teams in this context)
            [
                'name' => 'Novak Djokovic',
                'league_id' => $atpTour->id,
                'sport_id' => $atpTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Serbia',
                'city' => 'Belgrade',
                'venue' => 'ATP Tour',
                'founded' => 2003,
            ],
            [
                'name' => 'Rafael Nadal',
                'league_id' => $atpTour->id,
                'sport_id' => $atpTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Spain',
                'city' => 'Mallorca',
                'venue' => 'ATP Tour',
                'founded' => 2001,
            ],
            [
                'name' => 'Roger Federer',
                'league_id' => $atpTour->id,
                'sport_id' => $atpTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Switzerland',
                'city' => 'Basel',
                'venue' => 'ATP Tour',
                'founded' => 1998,
            ],
            [
                'name' => 'Carlos Alcaraz',
                'league_id' => $atpTour->id,
                'sport_id' => $atpTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Spain',
                'city' => 'Murcia',
                'venue' => 'ATP Tour',
                'founded' => 2018,
            ],
            // Volleyball Teams
            [
                'name' => 'Brazil National Team',
                'league_id' => $fivbTour->id,
                'sport_id' => $fivbTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Brazil',
                'city' => 'Rio de Janeiro',
                'venue' => 'FIVB World Tour',
                'founded' => 1917,
            ],
            [
                'name' => 'Italy National Team',
                'league_id' => $fivbTour->id,
                'sport_id' => $fivbTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Italy',
                'city' => 'Rome',
                'venue' => 'FIVB World Tour',
                'founded' => 1946,
            ],
            [
                'name' => 'USA National Team',
                'league_id' => $fivbTour->id,
                'sport_id' => $fivbTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'USA',
                'city' => 'Colorado Springs',
                'venue' => 'FIVB World Tour',
                'founded' => 1947,
            ],
            [
                'name' => 'Russia National Team',
                'league_id' => $fivbTour->id,
                'sport_id' => $fivbTour->sport_id,
                'logo_url' => 'https://via.placeholder.com/150',
                'country' => 'Russia',
                'city' => 'Moscow',
                'venue' => 'FIVB World Tour',
                'founded' => 1948,
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