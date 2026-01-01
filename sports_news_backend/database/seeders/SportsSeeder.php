<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Sport;

class SportsSeeder extends Seeder
{
    public function run(): void
    {
        $sports = [
            [
                'name' => 'Football',
                'icon' => 'sports_soccer',
                'color' => '#43A047',
                'description' => 'The beautiful game loved by billions worldwide',
                'emoji' => '⚽',
            ],
            [
                'name' => 'Basketball',
                'icon' => 'sports_basketball',
                'color' => '#FF9800',
                'description' => 'Fast-paced action on the hardwood court',
                'emoji' => '🏀',
            ],
            [
                'name' => 'Tennis',
                'icon' => 'sports_tennis',
                'color' => '#F57C00',
                'description' => 'Elite individual competition on various surfaces',
                'emoji' => '🎾',
            ],
            [
                'name' => 'Volleyball',
                'icon' => 'sports_volleyball',
                'color' => '#1976D2',
                'description' => 'Exciting team sport with powerful spikes and digs',
                'emoji' => '🏐',
            ],
        ];

        foreach ($sports as $sport) {
            Sport::create($sport);
        }
    }
}