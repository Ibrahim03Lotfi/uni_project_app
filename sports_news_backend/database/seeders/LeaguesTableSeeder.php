<?php

namespace Database\Seeders;
use App\Models\League;
use App\Models\Sport;
use Illuminate\Database\Seeder;

class LeaguesTableSeeder extends Seeder
{
    public function run()
    {
        $football = Sport::where('name', 'Football')->first();
        $basketball = Sport::where('name', 'Basketball')->first();
        $tennis = Sport::where('name', 'Tennis')->first();

        $leagues = [
            // Football Leagues
            [
                'name' => 'Premier League',
                'country' => 'England',
                'sport_id' => $football->id,
                'logo_emoji' => '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
                'season' => '2024/2025',
                'confederation' => 'UEFA',
            ],
            [
                'name' => 'La Liga',
                'country' => 'Spain',
                'sport_id' => $football->id,
                'logo_emoji' => '🇪🇸',
                'season' => '2024/2025',
                'confederation' => 'UEFA',
            ],
            // Basketball Leagues
            [
                'name' => 'NBA',
                'country' => 'USA',
                'sport_id' => $basketball->id,
                'logo_emoji' => '🏀',
                'season' => '2024/2025',
                'confederation' => 'FIBA',
            ],
            // Tennis Leagues
            [
                'name' => 'ATP Tour',
                'country' => 'International',
                'sport_id' => $tennis->id,
                'logo_emoji' => '🎾',
                'season' => '2024',
                'confederation' => 'ITF',
            ],
        ];

        foreach ($leagues as $league) {
            League::firstOrCreate(
                ['name' => $league['name'], 'sport_id' => $league['sport_id']],
                $league
            );
        }
    }
}