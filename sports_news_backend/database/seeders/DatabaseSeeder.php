<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            SportsSeeder::class,
            LeaguesTableSeeder::class,
            TeamsTableSeeder::class,
            PlayersTableSeeder::class,
            AdminUserSeeder::class,
            NewsArticleSeeder::class,
        ]);
    }
}
