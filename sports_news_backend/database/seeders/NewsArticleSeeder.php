<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\NewsArticle;
use App\Models\Sport;
use App\Models\Team;
use Illuminate\Support\Str;

class NewsArticleSeeder extends Seeder
{
    public function run(): void
    {
        // Get admin users and sports
        $adminUsers = User::where('role', 'admin')->get();
        $sports = Sport::all();
        $teams = Team::all();

        $sampleNews = [
            [
                'title' => 'Champions League Final: Real Madrid vs Manchester City',
                'description' => 'An epic clash between two European giants as they battle for the most prestigious trophy in club football.',
                'content' => 'The Champions League final promises to be a spectacular encounter between Real Madrid and Manchester City. Both teams have shown exceptional form throughout the tournament, with star players ready to make their mark on this historic occasion. The match will take place at Wembley Stadium, with millions of fans expected to watch worldwide. Real Madrid, led by their experienced captain, will look to leverage their European pedigree, while Manchester City aims to continue their dominance under their world-class manager. Key battles across the pitch will determine who lifts the coveted trophy.',
                'category' => 'Match Preview',
                'sport_id' => 1, // Football
                'team_id' => $teams->firstWhere('name', 'Real Madrid')?->id,
                'published_at' => now()->subDays(2),
            ],
            [
                'title' => 'NBA Playoffs: Lakers Advance to Conference Finals',
                'description' => 'LeBron James leads Lakers to victory in a thrilling Game 7 against the Warriors.',
                'content' => 'The Los Angeles Lakers have secured their place in the Western Conference Finals after a dramatic Game 7 victory against the Golden State Warriors. LeBron James delivered a masterclass performance with 38 points, 12 rebounds, and 8 assists, silencing critics who questioned his ability to perform at the highest level at this stage of his career. The Lakers showed incredible resilience, coming back from a 15-point deficit in the third quarter. Anthony Davis provided the defensive anchor with 4 blocks and 15 rebounds, while Austin Reaves contributed crucial shots down the stretch.',
                'category' => 'Game Recap',
                'sport_id' => 2, // Basketball
                'team_id' => $teams->firstWhere('name', 'Lakers')?->id,
                'published_at' => now()->subDay(),
            ],
            [
                'title' => 'Wimbledon Finals: Alcaraz vs Djokovic Showdown',
                'description' => 'Two tennis legends face off in what promises to be an unforgettable final.',
                'content' => 'Carlos Alcaraz and Novak Djokovic will meet in the Wimbledon finals in a clash of generations. Alcaraz, the young Spanish sensation, has been in scintillating form, dropping only one set on his way to the final. Djokovic, chasing his 24th Grand Slam title, has shown why he remains the king of grass courts with his impeccable movement and mental toughness. Tennis fans around the world are eagerly anticipating what could be one of the greatest Wimbledon finals in history.',
                'category' => 'Tournament',
                'sport_id' => 3, // Tennis
                'published_at' => now()->subHours(6),
            ],
            [
                'title' => 'Transfer Window: Major Moves Shake Up European Football',
                'description' => 'Several high-profile transfers are set to transform the landscape of European football.',
                'content' => 'The summer transfer window has seen several blockbuster moves that could reshape the balance of power in European football. Young talents are moving to bigger clubs, while established stars are seeking new challenges. Notable transfers include a Brazilian winger joining a Premier League giant for a record fee, and an Argentine midfielder making his dream move to Spain. Football analysts are already debating how these moves will affect the upcoming season and which teams have strengthened their squads the most.',
                'category' => 'Transfer News',
                'sport_id' => 1, // Football
                'published_at' => now()->subHours(3),
            ],
            [
                'title' => 'Olympics 2024: Volleyball Tournament Preview',
                'description' => 'Teams from around the world prepare for battle in the Paris Olympics volleyball competition.',
                'content' => 'The volleyball tournament at the 2024 Paris Olympics promises to be one of the most competitive in history. Defending champions France will have home crowd advantage, but teams like Brazil, USA, and Italy are strong contenders. The tournament features both men\'s and women\'s competitions, with matches taking place in state-of-the-art venues. Players have been preparing for years for this moment, and the level of play is expected to be exceptional. Volleyball fans can look forward to two weeks of thrilling action.',
                'category' => 'Olympics',
                'sport_id' => 4, // Volleyball
                'published_at' => now()->subHours(12),
            ],
            [
                'title' => 'Breaking: New Speed Record in 100m Sprint',
                'description' => 'A young sprinter shocks the world by breaking the 10-second barrier in spectacular fashion.',
                'content' => 'In a stunning display of speed and power, a 21-year-old sprinter has broken the 100m world record at the Diamond League meeting in Monaco. Clocking an incredible 9.58 seconds, the athlete shaved 0.01 seconds off the previous record that had stood for over 15 years. Track and field experts are calling this one of the greatest performances in the history of the sport. The achievement marks the arrival of a new superstar in athletics and sets the stage for an exciting battle at the upcoming World Championships.',
                'category' => 'Breaking News',
                'sport_id' => 3, // Tennis (could be Athletics, but using existing sport)
                'published_at' => now()->subMinutes(30),
            ],
            [
                'title' => 'NBA Finals Preview: Celtics vs Mavericks',
                'description' => 'Two powerhouse teams prepare for an epic NBA Finals showdown.',
                'content' => 'The Boston Celtics and Dallas Mavericks are set to face off in what promises to be an NBA Finals for the ages. The Celtics, with their dominant defense and balanced scoring, have been the best team in the Eastern Conference all season. The Mavericks, led by their superstar guard, have been on an incredible playoff run. The series features fascinating matchups, including the battle between the Celtics\' defensive anchor and the Mavericks\' offensive genius. Basketball analysts are split on who has the advantage, making this one of the most unpredictable Finals in recent memory.',
                'category' => 'Preview',
                'sport_id' => 2, // Basketball
                'team_id' => $teams->firstWhere('name', 'Celtics')?->id,
                'published_at' => now()->subHours(2),
            ],
            [
                'title' => 'Champions League Group Stage Draw Completed',
                'description' => 'Europe\'s elite clubs learn their fate in the group stage draw.',
                'content' => 'The Champions League group stage draw has been completed, setting up some intriguing matchups. Defending champions face a tough group with two former winners, while several dark horses have been handed favorable draws. The group stage will feature some of the most talented players in world football, with matches taking place across Europe\'s most iconic stadiums. Football fans are already analyzing the groups and predicting which teams will advance to the knockout stages. The first matchday is just weeks away, and anticipation is building.',
                'category' => 'Draw Results',
                'sport_id' => 1, // Football
                'published_at' => now()->subMinutes(45),
            ],
        ];

        // Create news articles with different admin authors
        foreach ($sampleNews as $index => $newsData) {
            $author = $adminUsers->random();
            
            NewsArticle::create([
                'title' => $newsData['title'],
                'description' => $newsData['description'],
                'content' => $newsData['content'],
                'category' => $newsData['category'],
                'sport_id' => $newsData['sport_id'],
                'team_id' => $newsData['team_id'] ?? null,
                'author_id' => $author->id,
                'published_at' => $newsData['published_at'],
                'created_at' => $newsData['published_at'],
                'updated_at' => now(),
            ]);
        }

        $this->command->info('Sample news articles created successfully!');
    }
}
