import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// News Model
class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String sport;
  final DateTime publishedAt;
  final String author;
  final int likes;
  final int comments;
  final List<String> tags;
  final String fullContent;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.sport,
    required this.publishedAt,
    required this.author,
    this.likes = 0,
    this.comments = 0,
    required this.tags,
    required this.fullContent,
  });
}

// Sport Type Enum
enum SportType { all, football, basketball, tennis, volleyball }

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  SportType _selectedSport = SportType.all;
  final List<NewsArticle> _allNews = [];

  @override
  void initState() {
    super.initState();
    _initializeNews();
  }

  void _initializeNews() {
    // FOOTBALL NEWS
    _allNews.addAll([
      NewsArticle(
        id: 'news_1',
        title: 'Manchester United Announces New Manager',
        description:
            'The Red Devils have appointed a former player as their new head coach ahead of the 2024 season.',
        imageUrl: '🏆',
        category: 'Breaking News',
        sport: 'football',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        author: 'Sky Sports',
        likes: 1245,
        comments: 234,
        tags: ['Premier League', 'Transfer', 'Manager'],
        fullContent: '''
Manchester United has officially announced the appointment of former club legend Ole Gunnar Solskjær as their new head coach. The Norwegian returns to Old Trafford after spending three seasons away from the club.

The decision was made after an extensive search following the departure of their previous manager. Solskjær, who scored the winning goal in the 1999 Champions League final, is no stranger to the club, having previously managed them from 2018 to 2021.

"I'm delighted to be back at Manchester United," Solskjær said in a statement. "This club has always been in my heart, and I'm excited to work with this talented group of players. We have a clear vision for the future and are committed to bringing success back to Old Trafford."

The announcement comes at a crucial time for United, who are currently 5th in the Premier League table. Fans have expressed mixed reactions, with many remembering Solskjær's previous tenure where he led the team to a second-place finish in the 2020-21 season.

Assistant coaching staff is expected to be announced in the coming days. The new manager will take charge immediately, with his first match scheduled for this weekend against Arsenal at the Emirates Stadium.
        ''',
      ),
      NewsArticle(
        id: 'news_2',
        title: 'Real Madrid Secures Champions League Semi-final Spot',
        description:
            'Spanish giants defeat Manchester City in a thrilling quarter-final match at Santiago Bernabéu.',
        imageUrl: '⭐',
        category: 'Match Report',
        sport: 'football',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
        author: 'ESPN FC',
        likes: 2890,
        comments: 456,
        tags: ['Champions League', 'Real Madrid', 'Manchester City'],
        fullContent: '''
Real Madrid booked their place in the Champions League semi-finals with a dramatic 4-3 aggregate victory over Manchester City. The second leg at the Santiago Bernabéu ended 1-1, securing Madrid\'s passage to the last four.

Rodrygo opened the scoring for Madrid in the 12th minute, capitalizing on a defensive error from City. The English champions responded through Kevin De Bruyne in the 36th minute, setting up a tense second half.

Both teams had chances to win the tie, with Karim Benzema hitting the post in the 67th minute and Erling Haaland seeing a close-range effort saved by Thibaut Courtois minutes later. The match ended with Madrid holding on to secure their place in the semi-finals for the third consecutive season.

Manager Carlo Ancelotti praised his team\'s resilience: "We showed great character tonight. This is what Real Madrid is about - we never give up, even in difficult moments. The players gave everything on the pitch."

Madrid will now face Bayern Munich in the semi-finals, with the first leg scheduled for next week at the Allianz Arena.
        ''',
      ),
      NewsArticle(
        id: 'news_3',
        title: 'Mbappé Sets New Ligue 1 Goal Record',
        description:
            'PSG star breaks the single-season scoring record with his 35th goal of the campaign.',
        imageUrl: '⚽',
        category: 'Records',
        sport: 'football',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        author: 'L\'Équipe',
        likes: 1789,
        comments: 312,
        tags: ['PSG', 'Records', 'Ligue 1'],
        fullContent: '''
Kylian Mbappé has rewritten the Ligue 1 history books by setting a new single-season scoring record. The Paris Saint-Germain forward scored his 35th league goal of the season in a 3-0 victory over Marseille, surpassing the previous record of 34 goals set by Josip Skoblar in 1971.

The French international achieved the milestone in just 28 appearances, maintaining an incredible strike rate throughout the campaign. His record-breaking goal came in the 58th minute, a powerful left-footed strike from the edge of the box that left the Marseille goalkeeper with no chance.

"This record means a lot to me, but more important is helping the team win trophies," Mbappé said after the match. "I want to thank my teammates and the coaching staff for their support throughout the season."

Mbappé\'s achievement comes amid ongoing speculation about his future, with his contract set to expire at the end of the season. The 25-year-old has been linked with a move to Real Madrid, though no official announcement has been made.

PSG manager Luis Enrique praised his star player: "Kylian is a special talent. What he\'s achieving at his age is remarkable. He\'s not just a goal scorer - he\'s a complete forward who works hard for the team."
        ''',
      ),
    ]);

    // BASKETBALL NEWS
    _allNews.addAll([
      NewsArticle(
        id: 'news_4',
        title: 'LeBron James Reaches 40,000 Career Points',
        description:
            'Lakers star becomes first player in NBA history to reach the historic milestone.',
        imageUrl: '🏀',
        category: 'History Made',
        sport: 'basketball',
        publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
        author: 'NBA.com',
        likes: 3456,
        comments: 789,
        tags: ['NBA', 'LeBron James', 'Records'],
        fullContent: '''
LeBron James has etched his name deeper into the NBA history books by becoming the first player to reach 40,000 career points. The Los Angeles Lakers star achieved the milestone during Thursday night\'s game against the Denver Nuggets at Crypto.com Arena.

James needed 9 points entering the game to reach the historic mark. He achieved it with a driving layup in the second quarter, prompting a standing ovation from the sold-out crowd and a brief stoppage in play to acknowledge the achievement.

"It\'s surreal," James said after the game. "I never thought when I started this journey that I\'d be here talking about 40,000 points. I\'ve just tried to be available for my team and play the right way."

The 39-year-old is in his 21st NBA season and shows no signs of slowing down. He\'s averaging 25.2 points, 7.3 rebounds, and 8.1 assists per game this season, leading the Lakers in their push for playoff positioning.

NBA Commissioner Adam Silver released a statement congratulating James: "LeBron continues to redefine what\'s possible in our game. His longevity, excellence, and impact on and off the court are truly remarkable."
        ''',
      ),
      NewsArticle(
        id: 'news_5',
        title: 'Warriors Clinch Playoff Berth With Curry\'s 50-Point Game',
        description:
            'Stephen Curry puts on a shooting clinic to secure Golden State\'s postseason spot.',
        imageUrl: '💙💛',
        category: 'Game Highlights',
        sport: 'basketball',
        publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
        author: 'SportsCenter',
        likes: 2345,
        comments: 567,
        tags: ['Warriors', 'Stephen Curry', 'Playoffs'],
        fullContent: '''
The Golden State Warriors secured their playoff spot in dramatic fashion as Stephen Curry erupted for 50 points in a must-win game against the Phoenix Suns. The two-time MVP shot 18-for-28 from the field, including 11 three-pointers, in one of his best performances of the season.

Curry\'s 50-point explosion came at the perfect time for the Warriors, who needed a victory to clinch the final playoff spot in the Western Conference. The game was tied at 110-110 with two minutes remaining when Curry took over, scoring 10 straight points to seal the victory.

"When the stakes are high, you want the ball in Steph\'s hands," Warriors coach Steve Kerr said. "He\'s the greatest shooter of all time, and tonight he showed why. This was one of the most clutch performances I\'ve ever seen."

The victory ensures the Warriors will make their 10th playoff appearance in the last 12 seasons. They will face the top-seeded Denver Nuggets in the first round, with Game 1 scheduled for Sunday.

Curry downplayed his individual performance: "This was a team win. Everyone stepped up when we needed them. We\'re just getting started - the real work begins now in the playoffs."
        ''',
      ),
      NewsArticle(
        id: 'news_6',
        title: 'Victor Wembanyama Wins Rookie of the Year',
        description:
            'Spurs phenom becomes unanimous choice for the prestigious award.',
        imageUrl: '🦓',
        category: 'Awards',
        sport: 'basketball',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        author: 'The Athletic',
        likes: 1987,
        comments: 423,
        tags: ['Spurs', 'Wembanyama', 'Rookie'],
        fullContent: '''
San Antonio Spurs center Victor Wembanyama has been named the unanimous NBA Rookie of the Year, becoming the first player since Karl-Anthony Towns in 2016 to receive every first-place vote. The French phenom averaged 21.4 points, 10.6 rebounds, and 3.6 blocks per game in his debut season.

Wembanyama\'s impact was immediate and profound. He led all rookies in scoring, rebounding, and blocks, while also showcasing remarkable defensive instincts that made him a contender for Defensive Player of the Year. His 10 triple-doubles were the most by a rookie in NBA history.

"I\'m honored to receive this award, but credit goes to my teammates and coaches who believed in me from day one," Wembanyama said. "San Antonio has been the perfect place for my development, and I\'m excited for what\'s to come."

Spurs coach Gregg Popovich praised his young star: "Victor is a generational talent. What\'s most impressive isn\'t just his physical gifts, but his basketball IQ and work ethic. He\'s only scratched the surface of what he can become."

The award adds to Wembanyama\'s growing list of accomplishments, which includes being named to the All-Defensive Second Team. At 20 years old, he\'s already being mentioned among the best young players in league history.
        ''',
      ),
    ]);

    // TENNIS NEWS
    _allNews.addAll([
      NewsArticle(
        id: 'news_7',
        title: 'Djokovic Announces Return From Injury',
        description:
            'World No. 1 confirms he\'ll defend his French Open title after recovering from wrist surgery.',
        imageUrl: '🎾',
        category: 'Injury Update',
        sport: 'tennis',
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
        author: 'Tennis Channel',
        likes: 1567,
        comments: 289,
        tags: ['Djokovic', 'French Open', 'Injury'],
        fullContent: '''
Novak Djokovic has announced he will return to competition in time to defend his French Open title, putting an end to speculation about his participation. The world No. 1 has been recovering from wrist surgery he underwent in February.

"I\'m happy to confirm that I\'ll be ready for Roland Garros," Djokovic said in a statement. "The recovery has gone better than expected, and I\'ve been able to practice without pain for the past two weeks. I feel strong and motivated to defend my title."

Djokovic underwent arthroscopic surgery on his right wrist after experiencing discomfort during the Australian Open. The procedure was successful, and he has been undergoing intensive rehabilitation at his training base in Monte Carlo.

The Serbian star is chasing his 25th Grand Slam title, which would extend his record as the most successful male player in tennis history. He has won the French Open three times, most recently in 2023 when he defeated Casper Ruud in the final.

French Open tournament director Amélie Mauresmo welcomed the news: "Having Novak defend his title is fantastic for the tournament and for tennis fans around the world. He\'s one of the greatest champions our sport has ever seen."
        ''',
      ),
      NewsArticle(
        id: 'news_8',
        title: 'Carlos Alcaraz Wins Madrid Open',
        description:
            'Spanish sensation defeats Andrey Rublev in straight sets to claim his second Madrid title.',
        imageUrl: '🇪🇸',
        category: 'Tournament Win',
        sport: 'tennis',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        author: 'ATP Tour',
        likes: 1890,
        comments: 345,
        tags: ['Alcaraz', 'Madrid Open', 'ATP'],
        fullContent: '''
Carlos Alcaraz continued his dominance on home soil by winning the Madrid Open for the second time in three years. The 21-year-old defeated Andrey Rublev 6-4, 6-3 in a commanding performance that showcased his all-court game.

Playing in front of a passionate Spanish crowd, Alcaraz broke Rublev\'s serve three times and saved all four break points he faced. His aggressive baseline play combined with deft touch at the net proved too much for the Russian, who was seeking his first Masters 1000 title.

"This victory means everything to me," Alcaraz said after the match. "Playing in Madrid, in front of my home fans, is always special. I want to thank everyone who came out to support me - this trophy is for Spain."

The win moves Alcaraz to No. 2 in the ATP rankings and strengthens his position as one of the favorites for the upcoming French Open. He has now won three titles this season and has a 32-4 win-loss record.

Coach Juan Carlos Ferrero praised his pupil\'s maturity: "Carlos is growing with every tournament. He showed great mental strength today and executed our game plan perfectly. The best is yet to come."
        ''',
      ),
    ]);

    // VOLLEYBALL NEWS
    _allNews.addAll([
      NewsArticle(
        id: 'news_9',
        title: 'Italy Wins Men\'s Volleyball Nations League',
        description:
            'Italian team defeats Brazil in five-set thriller to claim the championship.',
        imageUrl: '🇮🇹',
        category: 'Championship',
        sport: 'volleyball',
        publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
        author: 'FIVB',
        likes: 987,
        comments: 156,
        tags: ['Italy', 'Nations League', 'Champions'],
        fullContent: '''
Italy has been crowned champions of the Men\'s Volleyball Nations League after a thrilling five-set victory over Brazil in the final. The match ended 3-2 (25-23, 22-25, 25-20, 21-25, 15-13) in front of a sell-out crowd in Tokyo.

Alessandro Michieletto was named MVP of the tournament after scoring 28 points in the final, including the championship-winning spike. The 22-year-old outside hitter was instrumental throughout the match, delivering crucial points when Italy needed them most.

"This is a dream come true," Michieletto said. "Winning for Italy, with this team, in such an important tournament - there are no words to describe this feeling. We fought until the end, and this victory belongs to all of Italian volleyball."

The victory marks Italy\'s second Nations League title, having previously won in 2022. They finished the tournament with a 12-2 record, defeating Poland in the semi-finals before overcoming Brazil in the championship match.

Italian coach Ferdinando De Giorgi praised his team\'s resilience: "This was a battle from start to finish. Brazil pushed us to our limits, but our players showed incredible heart and determination. They never gave up, and that\'s why we\'re champions."
        ''',
      ),
      NewsArticle(
        id: 'news_10',
        title: 'USA Women\'s Team Qualifies for Olympics',
        description:
            'American squad secures Paris 2024 berth with victory over Dominican Republic.',
        imageUrl: '🇺🇸',
        category: 'Olympics',
        sport: 'volleyball',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 7)),
        author: 'USA Volleyball',
        likes: 1234,
        comments: 234,
        tags: ['USA', 'Olympics', 'Qualification'],
        fullContent: '''
The United States women\'s volleyball team has secured its place at the Paris 2024 Olympics with a convincing 3-0 victory over the Dominican Republic in the final Olympic qualifier. The Americans won 25-19, 25-21, 25-18 to book their ticket to France.

Jordan Larson, who came out of retirement for the qualifying tournament, led the way with 18 points. The 37-year-old captain showed why she\'s considered one of the greatest players in USA volleyball history, providing leadership and scoring when it mattered most.

"Qualifying for the Olympics is always special, but doing it with this group makes it even more meaningful," Larson said. "We have a great mix of experienced players and young talent, and I believe we can medal in Paris."

The victory extends USA\'s streak of Olympic appearances to 11 consecutive Games. They will enter Paris 2024 as one of the favorites, having won silver in Tokyo 2020 and bronze in Rio 2016.

Head coach Karch Kiraly was pleased with his team\'s performance: "The players executed our game plan perfectly. We showed our depth and versatility today. Now the real work begins as we prepare for Paris."
        ''',
      ),
    ]);

    // Sort by most recent
    _allNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  List<NewsArticle> get _filteredNews {
    if (_selectedSport == SportType.all) {
      return _allNews;
    }
    return _allNews.where((news) => news.sport == _selectedSport.name).toList();
  }

  Color _getSportColor(SportType sport) {
    switch (sport) {
      case SportType.football:
        return primaryGreen;
      case SportType.basketball:
        return Colors.orange[700]!;
      case SportType.tennis:
        return Colors.yellow[800]!;
      case SportType.volleyball:
        return Colors.blue[700]!;
      case SportType.all:
        return primaryGreen;
    }
  }

  IconData _getSportIcon(SportType sport) {
    switch (sport) {
      case SportType.football:
        return Icons.sports_soccer;
      case SportType.basketball:
        return Icons.sports_basketball;
      case SportType.tennis:
        return Icons.sports_tennis;
      case SportType.volleyball:
        return Icons.sports_volleyball;
      case SportType.all:
        return Icons.newspaper;
    }
  }

  String _getSportTitle(SportType sport) {
    switch (sport) {
      case SportType.football:
        return 'Football';
      case SportType.basketball:
        return 'Basketball';
      case SportType.tennis:
        return 'Tennis';
      case SportType.volleyball:
        return 'Volleyball';
      case SportType.all:
        return 'All Sports';
    }
  }

  void _navigateToNewsDetails(BuildContext context, NewsArticle article) {
    // Navigate to news details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailsPage(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Sport Filter
            _buildSportFilter(),
            // Content
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Sports News',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_filteredNews.length}',
              style: const TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportFilter() {
    final sports = [
      (SportType.all, Icons.newspaper, 'All'),
      (SportType.football, Icons.sports_soccer, 'Football'),
      (SportType.basketball, Icons.sports_basketball, 'Basketball'),
      (SportType.tennis, Icons.sports_tennis, 'Tennis'),
      (SportType.volleyball, Icons.sports_volleyball, 'Volleyball'),
    ];

    return Container(
      height: 50,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: sports.length,
        itemBuilder: (context, index) {
          final sport = sports[index];
          final isSelected = _selectedSport == sport.$1;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedSport = sport.$1;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _getSportColor(sport.$1)
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? _getSportColor(sport.$1)
                          : Theme.of(context).colorScheme.outlineVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        sport.$2,
                        size: 18,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        sport.$3,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    final news = _filteredNews;

    if (news.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getSportColor(_selectedSport).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getSportIcon(_selectedSport),
                    color: _getSportColor(_selectedSport),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getSportTitle(_selectedSport),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${news.length} news articles',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: news.length,
              itemBuilder: (context, index) {
                final article = news[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildNewsCard(article),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(NewsArticle article) {
    final sportColor = _getSportColor(
      SportType.values.firstWhere((e) => e.name == article.sport),
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToNewsDetails(context, article),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: sportColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(
                    article.imageUrl,
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category and Time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: sportColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: sportColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getTimeAgo(article.publishedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.sport.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Title
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      article.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    // Footer
                    Row(
                      children: [
                        // Author
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              article.author,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Likes and Comments
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${article.likes}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.comment_outlined,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${article.comments}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Read More
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: sportColor.withOpacity(0.2)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Read Full Article',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: sportColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: sportColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getSportIcon(_selectedSport),
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No News Available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No ${_selectedSport != SportType.all ? _getSportTitle(_selectedSport).toLowerCase() : ''} news found at the moment',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}

// News Details Page
class NewsDetailsPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final sportColor = _getSportColor(article.sport);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with back button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: _NewsPageState.darkGreen,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'News Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Share functionality
                      },
                      icon: const Icon(
                        Icons.share,
                        color: _NewsPageState.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
              // News Content
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          article.imageUrl,
                          style: const TextStyle(fontSize: 72),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and Sport
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: sportColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  article.category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: sportColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  article.sport.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Title
                          Text(
                            article.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Meta Info
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 16,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                article.author,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateFormat(
                                  'MMM d, yyyy • HH:mm',
                                ).format(article.publishedAt),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Full Content
                          Text(
                            article.fullContent,
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSurface,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: article.tags.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '#$tag',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          // Stats
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: sportColor,
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${article.likes}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: sportColor,
                                      ),
                                    ),
                                    Text(
                                      'Likes',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.comment_outlined,
                                      color: sportColor,
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${article.comments}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: sportColor,
                                      ),
                                    ),
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.share_outlined,
                                      color: sportColor,
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'Article',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Back Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: sportColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Back to News',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSportColor(String sport) {
    switch (sport) {
      case 'football':
        return const Color(0xFF43A047);
      case 'basketball':
        return Colors.orange[700]!;
      case 'tennis':
        return Colors.yellow[800]!;
      case 'volleyball':
        return Colors.blue[700]!;
      default:
        return const Color(0xFF43A047);
    }
  }
}
