<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Player;
use App\Models\Team;

class PlayersTableSeeder extends Seeder
{
    public function run()
    {
        // Get existing teams to assign players
        $teams = DB::table('teams')->get();
        
        $players = [
            // Football Players
            ['name' => 'Lionel Messi', 'position' => 'Forward', 'jersey_number' => 10, 'nationality' => 'Argentina', 'team_id' => 1, 'sport_id' => 1, 'image_emoji' => '🇦🇷', 'flag_emoji' => '🇦🇷'],
            ['name' => 'Cristiano Ronaldo', 'position' => 'Forward', 'jersey_number' => 7, 'nationality' => 'Portugal', 'team_id' => 2, 'sport_id' => 1, 'image_emoji' => '🇵🇹', 'flag_emoji' => '🇵🇹'],
            ['name' => 'Neymar Jr', 'position' => 'Forward', 'jersey_number' => 10, 'nationality' => 'Brazil', 'team_id' => 3, 'sport_id' => 1, 'image_emoji' => '🇧🇷', 'flag_emoji' => '🇧🇷'],
            ['name' => 'Kevin De Bruyne', 'position' => 'Midfielder', 'jersey_number' => 17, 'nationality' => 'Belgium', 'team_id' => 4, 'sport_id' => 1, 'image_emoji' => '🇧🇪', 'flag_emoji' => '🇧🇪'],
            ['name' => 'Erling Haaland', 'position' => 'Forward', 'jersey_number' => 9, 'nationality' => 'Norway', 'team_id' => 1, 'sport_id' => 1, 'image_emoji' => '🇳🇴', 'flag_emoji' => '🇳🇴'],
            ['name' => 'Kylian Mbappé', 'position' => 'Forward', 'jersey_number' => 7, 'nationality' => 'France', 'team_id' => 5, 'sport_id' => 1, 'image_emoji' => '🇫🇷', 'flag_emoji' => '🇫🇷'],
            ['name' => 'Robert Lewandowski', 'position' => 'Forward', 'jersey_number' => 9, 'nationality' => 'Poland', 'team_id' => 6, 'sport_id' => 1, 'image_emoji' => '🇵🇱', 'flag_emoji' => '🇵🇱'],
            ['name' => 'Virgil van Dijk', 'position' => 'Defender', 'jersey_number' => 4, 'nationality' => 'Netherlands', 'team_id' => 3, 'sport_id' => 1, 'image_emoji' => '🇳🇱', 'flag_emoji' => '🇳🇱'],
            ['name' => 'Mohamed Salah', 'position' => 'Forward', 'jersey_number' => 11, 'nationality' => 'Egypt', 'team_id' => 3, 'sport_id' => 1, 'image_emoji' => '🇪🇬', 'flag_emoji' => '🇪🇬'],
            ['name' => 'Thiago Silva', 'position' => 'Defender', 'jersey_number' => 6, 'nationality' => 'Brazil', 'team_id' => 4, 'sport_id' => 1, 'image_emoji' => '🇧🇷', 'flag_emoji' => '🇧🇷'],

            // Basketball Players
            ['name' => 'LeBron James', 'position' => 'Small Forward', 'jersey_number' => 23, 'nationality' => 'USA', 'team_id' => 7, 'sport_id' => 2, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
            ['name' => 'Stephen Curry', 'position' => 'Point Guard', 'jersey_number' => 30, 'nationality' => 'USA', 'team_id' => 8, 'sport_id' => 2, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
            ['name' => 'Kevin Durant', 'position' => 'Small Forward', 'jersey_number' => 35, 'nationality' => 'USA', 'team_id' => 9, 'sport_id' => 2, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
            ['name' => 'Giannis Antetokounmpo', 'position' => 'Power Forward', 'jersey_number' => 34, 'nationality' => 'Greece', 'team_id' => 10, 'sport_id' => 2, 'image_emoji' => '🇬🇷', 'flag_emoji' => '🇬🇷'],
            ['name' => 'Luka Dončić', 'position' => 'Point Guard', 'jersey_number' => 77, 'nationality' => 'Slovenia', 'team_id' => 8, 'sport_id' => 2, 'image_emoji' => '🇸🇮', 'flag_emoji' => '🇸🇮'],
            ['name' => 'Joel Embiid', 'position' => 'Center', 'jersey_number' => 21, 'nationality' => 'Cameroon', 'team_id' => 9, 'sport_id' => 2, 'image_emoji' => '🇨🇲', 'flag_emoji' => '🇨🇲'],
            ['name' => 'Nikola Jokić', 'position' => 'Center', 'jersey_number' => 15, 'nationality' => 'Serbia', 'team_id' => 7, 'sport_id' => 2, 'image_emoji' => '🇷🇸', 'flag_emoji' => '🇷🇸'],
            ['name' => 'Jayson Tatum', 'position' => 'Small Forward', 'jersey_number' => 0, 'nationality' => 'USA', 'team_id' => 8, 'sport_id' => 2, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
            ['name' => 'Jimmy Butler', 'position' => 'Small Forward', 'jersey_number' => 22, 'nationality' => 'USA', 'team_id' => 10, 'sport_id' => 2, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],

            // Tennis Players
            ['name' => 'Novak Djokovic', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Serbia', 'team_id' => 11, 'sport_id' => 3, 'image_emoji' => '🇷🇸', 'flag_emoji' => '🇷🇸'],
            ['name' => 'Rafael Nadal', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Spain', 'team_id' => 12, 'sport_id' => 3, 'image_emoji' => '🇪🇸', 'flag_emoji' => '🇪🇸'],
            ['name' => 'Roger Federer', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Switzerland', 'team_id' => 13, 'sport_id' => 3, 'image_emoji' => '🇨🇭', 'flag_emoji' => '🇨🇭'],
            ['name' => 'Carlos Alcaraz', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Spain', 'team_id' => 14, 'sport_id' => 3, 'image_emoji' => '🇪🇸', 'flag_emoji' => '🇪🇸'],
            ['name' => 'Daniil Medvedev', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Russia', 'team_id' => 11, 'sport_id' => 3, 'image_emoji' => '🇷🇺', 'flag_emoji' => '🇷🇺'],
            ['name' => 'Alexander Zverev', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Germany', 'team_id' => 12, 'sport_id' => 3, 'image_emoji' => '🇩🇪', 'flag_emoji' => '🇩🇪'],
            ['name' => 'Stefanos Tsitsipas', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Greece', 'team_id' => 13, 'sport_id' => 3, 'image_emoji' => '🇬🇷', 'flag_emoji' => '🇬🇷'],
            ['name' => 'Jannik Sinner', 'position' => 'Player', 'jersey_number' => null, 'nationality' => 'Italy', 'team_id' => 14, 'sport_id' => 3, 'image_emoji' => '🇮🇹', 'flag_emoji' => '🇮🇹'],

            // Volleyball Players
            ['name' => 'Giba', 'position' => 'Outside Hitter', 'jersey_number' => 10, 'nationality' => 'Brazil', 'team_id' => 15, 'sport_id' => 4, 'image_emoji' => '🇧🇷', 'flag_emoji' => '🇧🇷'],
            ['name' => 'Ivan Zaytsev', 'position' => 'Setter', 'jersey_number' => 8, 'nationality' => 'Italy', 'team_id' => 16, 'sport_id' => 4, 'image_emoji' => '🇮🇹', 'flag_emoji' => '🇮🇹'],
            ['name' => 'Wilfredo León', 'position' => 'Opposite Hitter', 'jersey_number' => 9, 'nationality' => 'Cuba', 'team_id' => 17, 'sport_id' => 4, 'image_emoji' => '🇨🇺', 'flag_emoji' => '🇨🇺'],
            ['name' => 'Matt Anderson', 'position' => 'Outside Hitter', 'jersey_number' => 1, 'nationality' => 'USA', 'team_id' => 18, 'sport_id' => 4, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
            ['name' => 'Fabian Wizig', 'position' => 'Middle Blocker', 'jersey_number' => 4, 'nationality' => 'Germany', 'team_id' => 15, 'sport_id' => 4, 'image_emoji' => '🇩🇪', 'flag_emoji' => '🇩🇪'],
            ['name' => 'Bartosz Kurek', 'position' => 'Opposite Hitter', 'jersey_number' => 13, 'nationality' => 'Poland', 'team_id' => 16, 'sport_id' => 4, 'image_emoji' => '🇵🇱', 'flag_emoji' => '🇵🇱'],
            ['name' => 'Yaroslav Podlesny', 'position' => 'Middle Blocker', 'jersey_number' => 11, 'nationality' => 'Russia', 'team_id' => 18, 'sport_id' => 4, 'image_emoji' => '🇷🇺', 'flag_emoji' => '🇷🇺'],
            ['name' => 'Lucas Saatkamp', 'position' => 'Middle Blocker', 'jersey_number' => 5, 'nationality' => 'Brazil', 'team_id' => 17, 'sport_id' => 4, 'image_emoji' => '🇧🇷', 'flag_emoji' => '🇧🇷'],
            ['name' => 'Taylor Sander', 'position' => 'Outside Hitter', 'jersey_number' => 23, 'nationality' => 'USA', 'team_id' => 18, 'sport_id' => 4, 'image_emoji' => '🇺🇸', 'flag_emoji' => '🇺🇸'],
        ];

        foreach ($players as $player) {
            Player::firstOrCreate([
                'name' => $player['name'],
                'position' => $player['position'],
                'jersey_number' => $player['jersey_number'],
                'nationality' => $player['nationality'],
                'team_id' => $player['team_id'],
                'sport_id' => $player['sport_id'],
                'image_emoji' => $player['image_emoji'],
                'flag_emoji' => $player['flag_emoji'],
            ]);
        }
    }
}
