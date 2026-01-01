import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Sport Type Enum
enum SportType { football, basketball, tennis, volleyball }

// League Model
class League {
  final String id;
  final String name;
  final String logo;
  final SportType sport;
  final String country;
  final int totalTeams;
  final List<Match> upcomingMatches;

  League({
    required this.id,
    required this.name,
    required this.logo,
    required this.sport,
    required this.country,
    required this.totalTeams,
    required this.upcomingMatches,
  });
}

// Match Model
class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final DateTime dateTime;
  final String venue;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.dateTime,
    required this.venue,
  });
}

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);

  SportType _selectedSport = SportType.football;
  final Map<String, bool> _expandedLeagues = {};

  final Map<SportType, List<League>> _sportLeagues = {};

  @override
  void initState() {
    super.initState();
    _initializeLeagues();
  }

  void _initializeLeagues() {
    // FOOTBALL LEAGUES
    _sportLeagues[SportType.football] = [
      League(
        id: 'football_1',
        name: 'Premier League',
        logo: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
        sport: SportType.football,
        country: 'England',
        totalTeams: 20,
        upcomingMatches: [
          Match(
            id: 'm1',
            homeTeam: 'Man Utd',
            awayTeam: 'Liverpool',
            homeTeamLogo: '🔴',
            awayTeamLogo: '🔴',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 20)),
            venue: 'Old Trafford',
          ),
          Match(
            id: 'm2',
            homeTeam: 'Man City',
            awayTeam: 'Arsenal',
            homeTeamLogo: '🩵',
            awayTeamLogo: '🔴',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 18)),
            venue: 'Etihad Stadium',
          ),
          Match(
            id: 'm3',
            homeTeam: 'Chelsea',
            awayTeam: 'Tottenham',
            homeTeamLogo: '🔵',
            awayTeamLogo: '⚪',
            dateTime: DateTime.now().add(const Duration(days: 4, hours: 15)),
            venue: 'Stamford Bridge',
          ),
          Match(
            id: 'm4',
            homeTeam: 'Newcastle',
            awayTeam: 'Aston Villa',
            homeTeamLogo: '⚫⚪',
            awayTeamLogo: '🟣',
            dateTime: DateTime.now().add(const Duration(days: 5, hours: 21)),
            venue: 'St. James\' Park',
          ),
        ],
      ),
      League(
        id: 'football_2',
        name: 'La Liga',
        logo: '🇪🇸',
        sport: SportType.football,
        country: 'Spain',
        totalTeams: 20,
        upcomingMatches: [
          Match(
            id: 'm5',
            homeTeam: 'Real Madrid',
            awayTeam: 'Barcelona',
            homeTeamLogo: '⚪',
            awayTeamLogo: '🔵🔴',
            dateTime: DateTime.now().add(const Duration(days: 1, hours: 21)),
            venue: 'Bernabéu',
          ),
          Match(
            id: 'm6',
            homeTeam: 'Atletico Madrid',
            awayTeam: 'Sevilla',
            homeTeamLogo: '🔴⚪',
            awayTeamLogo: '⚪🔴',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 20)),
            venue: 'Metropolitano',
          ),
        ],
      ),
      League(
        id: 'football_3',
        name: 'Bundesliga',
        logo: '🇩🇪',
        sport: SportType.football,
        country: 'Germany',
        totalTeams: 18,
        upcomingMatches: [
          Match(
            id: 'm7',
            homeTeam: 'Bayern',
            awayTeam: 'Dortmund',
            homeTeamLogo: '🔴',
            awayTeamLogo: '🟡',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 18)),
            venue: 'Allianz Arena',
          ),
          Match(
            id: 'm8',
            homeTeam: 'Bayer Leverkusen',
            awayTeam: 'RB Leipzig',
            homeTeamLogo: '🔴⚫',
            awayTeamLogo: '🔴',
            dateTime: DateTime.now().add(const Duration(days: 4, hours: 19)),
            venue: 'BayArena',
          ),
        ],
      ),
      League(
        id: 'football_4',
        name: 'Serie A',
        logo: '🇮🇹',
        sport: SportType.football,
        country: 'Italy',
        totalTeams: 20,
        upcomingMatches: [
          Match(
            id: 'm9',
            homeTeam: 'Inter',
            awayTeam: 'AC Milan',
            homeTeamLogo: '🔵⚫',
            awayTeamLogo: '🔴⚫',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 20)),
            venue: 'San Siro',
          ),
          Match(
            id: 'm10',
            homeTeam: 'Juventus',
            awayTeam: 'Napoli',
            homeTeamLogo: '⚫⚪',
            awayTeamLogo: '🔵',
            dateTime: DateTime.now().add(const Duration(days: 5, hours: 21)),
            venue: 'Allianz Stadium',
          ),
        ],
      ),
      League(
        id: 'football_5',
        name: 'Ligue 1',
        logo: '🇫🇷',
        sport: SportType.football,
        country: 'France',
        totalTeams: 18,
        upcomingMatches: [
          Match(
            id: 'm11',
            homeTeam: 'PSG',
            awayTeam: 'Marseille',
            homeTeamLogo: '🔵🔴',
            awayTeamLogo: '⚪🔵',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 21)),
            venue: 'Parc des Princes',
          ),
        ],
      ),
      League(
        id: 'football_6',
        name: 'Champions League',
        logo: '⭐',
        sport: SportType.football,
        country: 'Europe',
        totalTeams: 32,
        upcomingMatches: [
          Match(
            id: 'm12',
            homeTeam: 'Real Madrid',
            awayTeam: 'Bayern Munich',
            homeTeamLogo: '⚪',
            awayTeamLogo: '🔴',
            dateTime: DateTime.now().add(const Duration(days: 4, hours: 21)),
            venue: 'Santiago Bernabéu',
          ),
        ],
      ),
    ];

    // BASKETBALL LEAGUES
    _sportLeagues[SportType.basketball] = [
      League(
        id: 'basketball_1',
        name: 'NBA',
        logo: '🏀',
        sport: SportType.basketball,
        country: 'USA',
        totalTeams: 30,
        upcomingMatches: [
          Match(
            id: 'm13',
            homeTeam: 'Lakers',
            awayTeam: 'Warriors',
            homeTeamLogo: '💜💛',
            awayTeamLogo: '💙💛',
            dateTime: DateTime.now().add(const Duration(days: 1, hours: 19)),
            venue: 'Crypto.com Arena',
          ),
          Match(
            id: 'm14',
            homeTeam: 'Celtics',
            awayTeam: 'Heat',
            homeTeamLogo: '🍀',
            awayTeamLogo: '🔥',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 19)),
            venue: 'TD Garden',
          ),
          Match(
            id: 'm15',
            homeTeam: 'Bucks',
            awayTeam: 'Nets',
            homeTeamLogo: '🦌',
            awayTeamLogo: '⚫⚪',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 20)),
            venue: 'Fiserv Forum',
          ),
        ],
      ),
      League(
        id: 'basketball_2',
        name: 'EuroLeague',
        logo: '🏆',
        sport: SportType.basketball,
        country: 'Europe',
        totalTeams: 18,
        upcomingMatches: [
          Match(
            id: 'm16',
            homeTeam: 'Real Madrid',
            awayTeam: 'Barcelona',
            homeTeamLogo: '⚪',
            awayTeamLogo: '🔵🔴',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 20)),
            venue: 'WiZink Center',
          ),
        ],
      ),
      League(
        id: 'basketball_3',
        name: 'CBA',
        logo: '🇨🇳',
        sport: SportType.basketball,
        country: 'China',
        totalTeams: 20,
        upcomingMatches: [
          Match(
            id: 'm17',
            homeTeam: 'Guangdong',
            awayTeam: 'Liaoning',
            homeTeamLogo: '🐯',
            awayTeamLogo: '🏆',
            dateTime: DateTime.now().add(const Duration(days: 4, hours: 19)),
            venue: 'Dongguan Arena',
          ),
        ],
      ),
    ];

    // TENNIS LEAGUES
    _sportLeagues[SportType.tennis] = [
      League(
        id: 'tennis_1',
        name: 'ATP Tour',
        logo: '🎾',
        sport: SportType.tennis,
        country: 'Worldwide',
        totalTeams: 0,
        upcomingMatches: [
          Match(
            id: 'm18',
            homeTeam: 'Djokovic',
            awayTeam: 'Alcaraz',
            homeTeamLogo: '🇷🇸',
            awayTeamLogo: '🇪🇸',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 14)),
            venue: 'Wimbledon',
          ),
          Match(
            id: 'm19',
            homeTeam: 'Nadal',
            awayTeam: 'Federer',
            homeTeamLogo: '🇪🇸',
            awayTeamLogo: '🇨🇭',
            dateTime: DateTime.now().add(const Duration(days: 5, hours: 15)),
            venue: 'Roland Garros',
          ),
        ],
      ),
      League(
        id: 'tennis_2',
        name: 'WTA Tour',
        logo: '🎾',
        sport: SportType.tennis,
        country: 'Worldwide',
        totalTeams: 0,
        upcomingMatches: [
          Match(
            id: 'm20',
            homeTeam: 'Świątek',
            awayTeam: 'Sabalenka',
            homeTeamLogo: '🇵🇱',
            awayTeamLogo: '🇧🇾',
            dateTime: DateTime.now().add(const Duration(days: 2, hours: 13)),
            venue: 'Australian Open',
          ),
        ],
      ),
    ];

    // VOLLEYBALL LEAGUES
    _sportLeagues[SportType.volleyball] = [
      League(
        id: 'volleyball_1',
        name: 'Italian Serie A',
        logo: '🇮🇹',
        sport: SportType.volleyball,
        country: 'Italy',
        totalTeams: 14,
        upcomingMatches: [
          Match(
            id: 'm21',
            homeTeam: 'Perugia',
            awayTeam: 'Modena',
            homeTeamLogo: '⚫🟡',
            awayTeamLogo: '💙💛',
            dateTime: DateTime.now().add(const Duration(days: 1, hours: 18)),
            venue: 'PalaBarton',
          ),
        ],
      ),
      League(
        id: 'volleyball_2',
        name: 'FIVB World League',
        logo: '🌍',
        sport: SportType.volleyball,
        country: 'Worldwide',
        totalTeams: 16,
        upcomingMatches: [
          Match(
            id: 'm22',
            homeTeam: 'Brazil',
            awayTeam: 'USA',
            homeTeamLogo: '🇧🇷',
            awayTeamLogo: '🇺🇸',
            dateTime: DateTime.now().add(const Duration(days: 3, hours: 17)),
            venue: 'Maracanãzinho',
          ),
        ],
      ),
    ];
  }

  List<League> get _currentLeagues {
    return _sportLeagues[_selectedSport] ?? [];
  }

  void _toggleLeagueExpansion(String leagueId) {
    setState(() {
      if (_expandedLeagues.containsKey(leagueId)) {
        _expandedLeagues[leagueId] = !_expandedLeagues[leagueId]!;
      } else {
        _expandedLeagues[leagueId] = true;
      }
    });
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
    }
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
              'Leagues',
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
              '${_currentLeagues.length}',
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
    final leagues = _currentLeagues;

    if (leagues.isEmpty) {
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
                        '${_getSportTitle(_selectedSport)} Leagues',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${leagues.length} major leagues',
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
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final league = leagues[index];
                final isExpanded = _expandedLeagues[league.id] ?? false;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildLeagueCard(league, isExpanded),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueCard(League league, bool isExpanded) {
    final sportColor = _getSportColor(league.sport);

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
      child: Column(
        children: [
          // League Header (Always visible)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleLeagueExpansion(league.id),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // League Logo
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          league.logo,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // League Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            league.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: sportColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  league.country,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: sportColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '• ${league.totalTeams} teams',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Dropdown Button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: isExpanded ? 0.5 : 0,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: sportColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expandable Content
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Container(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Divider(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  // Upcoming Matches Header
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 18, color: sportColor),
                      const SizedBox(width: 8),
                      Text(
                        'Upcoming Matches',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${league.upcomingMatches.length} matches',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Matches List
                  ...league.upcomingMatches.map((match) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildMatchItem(match, sportColor),
                    );
                  }),
                  // View All Button
                  if (league.upcomingMatches.isNotEmpty)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: sportColor.withOpacity(0.2)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Navigate to full schedule
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(
                                'View Full Schedule',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: sportColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildMatchItem(Match match, Color sportColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          // Teams side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Home Team
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          match.homeTeamLogo,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      match.homeTeam,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // VS Badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: sportColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: sportColor,
                    ),
                  ),
                ),
              ),
              // Away Team
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: sportColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          match.awayTeamLogo,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      match.awayTeam,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Date and Venue (below teams)
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: sportColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 14, color: sportColor),
                const SizedBox(width: 6),
                Text(
                  DateFormat('EEE, MMM d • HH:mm').format(match.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: sportColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (match.venue.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  Icon(Icons.location_on, size: 14, color: sportColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      match.venue,
                      style: TextStyle(fontSize: 12, color: sportColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
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
              'No Leagues Available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No ${_getSportTitle(_selectedSport).toLowerCase()} leagues found for now',
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
}
