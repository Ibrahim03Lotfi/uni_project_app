import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'match_datail_page.dart' as match_details;

// Sport Type Enum
enum SportType { football, basketball, tennis, volleyball }

// Match Status Enum
enum MatchStatus { scheduled, live, finished }

// Match Model
class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final DateTime dateTime;
  final String league;
  final SportType sport;
  final MatchStatus status;
  final int? homeScore;
  final int? awayScore;
  final String? liveMinute;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.dateTime,
    required this.league,
    required this.sport,
    required this.status,
    this.homeScore,
    this.awayScore,
    this.liveMinute,
  });
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  DateTime _selectedDate = DateTime.now();
  SportType? _selectedSport;
  List<Match> _allMatches = [];

  @override
  void initState() {
    super.initState();
    _initializeMatches();
  }

  void _initializeMatches() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _allMatches = [
      // TODAY - FOOTBALL MATCHES
      Match(
        id: 'match_1',
        homeTeam: 'Manchester United',
        awayTeam: 'Liverpool',
        homeTeamLogo: '🔴',
        awayTeamLogo: '🔴',
        dateTime: today.add(const Duration(hours: 15)),
        league: 'Premier League',
        sport: SportType.football,
        status: MatchStatus.live,
        homeScore: 2,
        awayScore: 1,
        liveMinute: '67\'',
      ),
      Match(
        id: 'match_2',
        homeTeam: 'Manchester City',
        awayTeam: 'Chelsea',
        homeTeamLogo: '🩵',
        awayTeamLogo: '🔵',
        dateTime: today.add(const Duration(hours: 17, minutes: 30)),
        league: 'Premier League',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_3',
        homeTeam: 'Arsenal',
        awayTeam: 'Tottenham',
        homeTeamLogo: '🔴',
        awayTeamLogo: '⚪',
        dateTime: today.add(const Duration(hours: 20)),
        league: 'Premier League',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_4',
        homeTeam: 'Real Madrid',
        awayTeam: 'Barcelona',
        homeTeamLogo: '⚪',
        awayTeamLogo: '🔵🔴',
        dateTime: today.add(const Duration(hours: 21)),
        league: 'La Liga',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_5',
        homeTeam: 'Bayern Munich',
        awayTeam: 'Dortmund',
        homeTeamLogo: '🔴',
        awayTeamLogo: '🟡',
        dateTime: today.add(const Duration(hours: 18, minutes: 30)),
        league: 'Bundesliga',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_6',
        homeTeam: 'Inter Milan',
        awayTeam: 'AC Milan',
        homeTeamLogo: '🔵⚫',
        awayTeamLogo: '🔴⚫',
        dateTime: today.add(const Duration(hours: 20, minutes: 45)),
        league: 'Serie A',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),

      // TODAY - BASKETBALL MATCHES
      Match(
        id: 'match_7',
        homeTeam: 'Lakers',
        awayTeam: 'Warriors',
        homeTeamLogo: '💜💛',
        awayTeamLogo: '💙💛',
        dateTime: today.add(const Duration(hours: 19)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_8',
        homeTeam: 'Celtics',
        awayTeam: 'Heat',
        homeTeamLogo: '🍀',
        awayTeamLogo: '🔥',
        dateTime: today.add(const Duration(hours: 19, minutes: 30)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_9',
        homeTeam: 'Real Madrid',
        awayTeam: 'Barcelona',
        homeTeamLogo: '⚪',
        awayTeamLogo: '🔵🔴',
        dateTime: today.add(const Duration(hours: 20, minutes: 30)),
        league: 'EuroLeague',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),

      // TODAY - TENNIS MATCHES
      Match(
        id: 'match_10',
        homeTeam: 'Novak Djokovic',
        awayTeam: 'Carlos Alcaraz',
        homeTeamLogo: '🇷🇸',
        awayTeamLogo: '🇪🇸',
        dateTime: today.add(const Duration(hours: 14)),
        league: 'ATP Finals',
        sport: SportType.tennis,
        status: MatchStatus.scheduled,
      ),

      // TODAY - VOLLEYBALL MATCHES
      Match(
        id: 'match_11',
        homeTeam: 'Perugia',
        awayTeam: 'Modena',
        homeTeamLogo: '⚫🟡',
        awayTeamLogo: '💙💛',
        dateTime: today.add(const Duration(hours: 18)),
        league: 'Serie A (Italy)',
        sport: SportType.volleyball,
        status: MatchStatus.scheduled,
      ),

      // TOMORROW - FOOTBALL MATCHES
      Match(
        id: 'match_12',
        homeTeam: 'PSG',
        awayTeam: 'Monaco',
        homeTeamLogo: '🔵🔴',
        awayTeamLogo: '🔴⚪',
        dateTime: today.add(const Duration(days: 1, hours: 21)),
        league: 'Ligue 1',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_13',
        homeTeam: 'Juventus',
        awayTeam: 'Napoli',
        homeTeamLogo: '⚫⚪',
        awayTeamLogo: '🔵',
        dateTime: today.add(const Duration(days: 1, hours: 20, minutes: 45)),
        league: 'Serie A',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_14',
        homeTeam: 'Inter Miami',
        awayTeam: 'LA Galaxy',
        homeTeamLogo: '🩷',
        awayTeamLogo: '🔵🟡',
        dateTime: today.add(const Duration(days: 1, hours: 19, minutes: 30)),
        league: 'MLS',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),

      // TOMORROW - BASKETBALL MATCHES
      Match(
        id: 'match_15',
        homeTeam: 'Bucks',
        awayTeam: 'Nets',
        homeTeamLogo: '🦌',
        awayTeamLogo: '⚫⚪',
        dateTime: today.add(const Duration(days: 1, hours: 19)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_16',
        homeTeam: 'Nuggets',
        awayTeam: 'Suns',
        homeTeamLogo: '⛏️',
        awayTeamLogo: '☀️',
        dateTime: today.add(const Duration(days: 1, hours: 21)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),

      // YESTERDAY - FINISHED MATCHES
      Match(
        id: 'match_17',
        homeTeam: 'Ajax',
        awayTeam: 'Porto',
        homeTeamLogo: '🔴⚪',
        awayTeamLogo: '🔵⚪',
        dateTime: today.subtract(const Duration(days: 1, hours: 3)),
        league: 'Eredivisie',
        sport: SportType.football,
        status: MatchStatus.finished,
        homeScore: 3,
        awayScore: 1,
      ),
      Match(
        id: 'match_18',
        homeTeam: 'Al-Nassr',
        awayTeam: 'Al-Hilal',
        homeTeamLogo: '🟡',
        awayTeamLogo: '🔵',
        dateTime: today.subtract(const Duration(days: 1, hours: 5)),
        league: 'Saudi Pro League',
        sport: SportType.football,
        status: MatchStatus.finished,
        homeScore: 2,
        awayScore: 2,
      ),
      Match(
        id: 'match_19',
        homeTeam: 'Bulls',
        awayTeam: 'Cavaliers',
        homeTeamLogo: '🐂',
        awayTeamLogo: '🍷',
        dateTime: today.subtract(const Duration(days: 1, hours: 6)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.finished,
        homeScore: 105,
        awayScore: 98,
      ),

      // DAY AFTER TOMORROW
      Match(
        id: 'match_20',
        homeTeam: 'Benfica',
        awayTeam: 'Sporting',
        homeTeamLogo: '🔴',
        awayTeamLogo: '🟢',
        dateTime: today.add(const Duration(days: 2, hours: 20)),
        league: 'Primeira Liga',
        sport: SportType.football,
        status: MatchStatus.scheduled,
      ),
      Match(
        id: 'match_21',
        homeTeam: 'Mavericks',
        awayTeam: 'Thunder',
        homeTeamLogo: '🐴',
        awayTeamLogo: '⚡',
        dateTime: today.add(const Duration(days: 2, hours: 20, minutes: 30)),
        league: 'NBA',
        sport: SportType.basketball,
        status: MatchStatus.scheduled,
      ),
    ];
  }

  List<Match> get _filteredMatches {
    final selectedDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    return _allMatches.where((match) {
      final matchDay = DateTime(
        match.dateTime.year,
        match.dateTime.month,
        match.dateTime.day,
      );

      final dateMatches = matchDay.isAtSameMomentAs(selectedDay);
      final sportMatches =
          _selectedSport == null || match.sport == _selectedSport;

      return dateMatches && sportMatches;
    }).toList();
  }

  Map<String, List<Match>> get _groupedMatches {
    final matches = _filteredMatches;
    final Map<String, List<Match>> grouped = {};

    for (var match in matches) {
      grouped.putIfAbsent(match.league, () => []).add(match);
    }

    // Sort matches within each league by time
    grouped.forEach((key, value) {
      value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    });

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _buildResponsiveLayout(constraints);
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    if (isDesktop) {
      return _buildDesktopLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  // ==================== DESKTOP LAYOUT ====================
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        _buildDesktopSidebar(),
        Expanded(
          child: Column(
            children: [
              _buildDesktopHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _buildMainContent(isDesktop: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'SportsFeed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Date Navigation
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDateSelector(),
              ],
            ),
          ),
          const Divider(height: 1),
          // Sports Filter
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Sport',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSportFilter(),
              ],
            ),
          ),
          const Divider(height: 1),
          // Match Statistics
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Matches',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMatchStats(),
              ],
            ),
          ),
          const Spacer(),
          // Total Matches Card
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryGreen.withOpacity(0.1),
                  lightGreen.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: lightGreen.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.calendar_today, color: primaryGreen, size: 40),
                const SizedBox(height: 12),
                Text(
                  '${_filteredMatches.length}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                Text(
                  _filteredMatches.length == 1 ? 'Match' : 'Matches',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    final dates = List.generate(7, (index) {
      return DateTime.now().subtract(Duration(days: 2 - index));
    });

    return Column(
      children: dates.map((date) {
        final isSelected = DateTime(date.year, date.month, date.day)
            .isAtSameMomentAs(
              DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
              ),
            );

        String label;
        final today = DateTime.now();
        final dateOnly = DateTime(date.year, date.month, date.day);
        final todayOnly = DateTime(today.year, today.month, today.day);

        if (dateOnly.isAtSameMomentAs(todayOnly)) {
          label = 'Today';
        } else if (dateOnly.isAtSameMomentAs(
          todayOnly.subtract(const Duration(days: 1)),
        )) {
          label = 'Yesterday';
        } else if (dateOnly.isAtSameMomentAs(
          todayOnly.add(const Duration(days: 1)),
        )) {
          label = 'Tomorrow';
        } else {
          label = DateFormat('EEE, MMM d').format(date);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? primaryGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? primaryGreen : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: isSelected ? Colors.white : Colors.grey[600],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[800],
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSportFilter() {
    final sports = [
      (SportType.football, Icons.sports_soccer, 'Football'),
      (SportType.basketball, Icons.sports_basketball, 'Basketball'),
      (SportType.tennis, Icons.sports_tennis, 'Tennis'),
      (SportType.volleyball, Icons.sports_volleyball, 'Volleyball'),
    ];

    return Column(
      children: [
        _buildSportFilterItem(null, Icons.sports, 'All Sports'),
        ...sports.map((sport) {
          return _buildSportFilterItem(sport.$1, sport.$2, sport.$3);
        }),
      ],
    );
  }

  Widget _buildSportFilterItem(SportType? sport, IconData icon, String label) {
    final isSelected = _selectedSport == sport;
    final color = sport != null ? _getSportColor(sport) : primaryGreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedSport = sport;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? color : Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? color : Colors.grey[600],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? color : Colors.grey[800],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchStats() {
    final liveMatches = _filteredMatches
        .where((m) => m.status == MatchStatus.live)
        .length;
    final scheduledMatches = _filteredMatches
        .where((m) => m.status == MatchStatus.scheduled)
        .length;
    final finishedMatches = _filteredMatches
        .where((m) => m.status == MatchStatus.finished)
        .length;

    return Column(
      children: [
        _buildStatRow('🔴 Live', liveMatches, Colors.red),
        _buildStatRow('⏰ Scheduled', scheduledMatches, Colors.blue),
        _buildStatRow('✅ Finished', finishedMatches, Colors.grey),
      ],
    );
  }

  Widget _buildStatRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Matches Schedule',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          _buildDateChips(),
        ],
      ),
    );
  }

  // ==================== TABLET LAYOUT ====================
  Widget _buildTabletLayout() {
    return Column(
      children: [
        _buildMobileHeader(),
        _buildDateChips(),
        _buildSportFilterChips(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildMatchesList(isDesktop: false),
          ),
        ),
      ],
    );
  }

  // ==================== MOBILE LAYOUT ====================
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMobileHeader(),
        _buildDateChips(),
        _buildSportFilterChips(),
        Expanded(child: _buildMatchesList(isDesktop: false)),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [
          /*  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: darkGreen),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),*/
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Matches',
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
              '${_filteredMatches.length}',
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

  Widget _buildDateChips() {
    final dates = List.generate(7, (index) {
      return DateTime.now().subtract(Duration(days: 2 - index));
    });

    return Container(
      height: 60,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = DateTime(date.year, date.month, date.day)
              .isAtSameMomentAs(
                DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                ),
              );

          String label;
          String subLabel;
          final today = DateTime.now();
          final dateOnly = DateTime(date.year, date.month, date.day);
          final todayOnly = DateTime(today.year, today.month, today.day);

          if (dateOnly.isAtSameMomentAs(todayOnly)) {
            label = 'Today';
            subLabel = DateFormat('MMM d').format(date);
          } else if (dateOnly.isAtSameMomentAs(
            todayOnly.subtract(const Duration(days: 1)),
          )) {
            label = 'Yesterday';
            subLabel = DateFormat('MMM d').format(date);
          } else if (dateOnly.isAtSameMomentAs(
            todayOnly.add(const Duration(days: 1)),
          )) {
            label = 'Tomorrow';
            subLabel = DateFormat('MMM d').format(date);
          } else {
            label = DateFormat('EEE').format(date);
            subLabel = DateFormat('MMM d').format(date);
          }

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
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
                        ? primaryGreen
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? primaryGreen
                          : Theme.of(context).colorScheme.outlineVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          subLabel,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white.withOpacity(0.9)
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSportFilterChips() {
    final sports = [
      (null, Icons.sports, 'All', primaryGreen),
      (SportType.football, Icons.sports_soccer, 'Football', primaryGreen),
      (
        SportType.basketball,
        Icons.sports_basketball,
        'Basketball',
        Colors.orange[700]!,
      ),
      (SportType.tennis, Icons.sports_tennis, 'Tennis', Colors.yellow[800]!),
      (
        SportType.volleyball,
        Icons.sports_volleyball,
        'Volleyball',
        Colors.blue[700]!,
      ),
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
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? sport.$4
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? sport.$4
                          : Theme.of(context).colorScheme.outlineVariant,
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

  Widget _buildMainContent({required bool isDesktop}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDateTitle(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_filteredMatches.length} matches scheduled',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildMatchesList(isDesktop: isDesktop)),
        ],
      ),
    );
  }

  Widget _buildMatchesList({required bool isDesktop}) {
    if (_filteredMatches.isEmpty) {
      return _buildEmptyState();
    }

    final grouped = _groupedMatches;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final league = grouped.keys.elementAt(index);
        final matches = grouped[league]!;
        final sportColor = _getSportColor(matches.first.sport);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) const SizedBox(height: 24),
            // League Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: sportColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getSportIcon(matches.first.sport),
                          size: 16,
                          color: sportColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          league,
                          style: TextStyle(
                            color: sportColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Matches
            ...matches.map((match) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildMatchCard(match, isDesktop: isDesktop),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildMatchCard(Match match, {required bool isDesktop}) {
    final sportColor = _getSportColor(match.sport);
    final timeFormat = DateFormat('HH:mm');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: match.status == MatchStatus.live
              ? Colors.red
              : Theme.of(context).colorScheme.outlineVariant,
          width: match.status == MatchStatus.live ? 2 : 1,
        ),
        boxShadow: match.status == MatchStatus.live
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    match_details.MatchDetailsPage(matchId: match.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Match Status and Time
                Row(
                  children: [
                    if (match.status == MatchStatus.live)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'LIVE ${match.liveMinute ?? ''}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (match.status == MatchStatus.finished)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'FT',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: sportColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: sportColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              timeFormat.format(match.dateTime),
                              style: TextStyle(
                                color: sportColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Teams
                Row(
                  children: [
                    // Home Team
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: sportColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                match.homeTeamLogo,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            match.homeTeam,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Score or VS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          if (match.status == MatchStatus.live ||
                              match.status == MatchStatus.finished)
                            Row(
                              children: [
                                Text(
                                  '${match.homeScore}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: match.status == MatchStatus.live
                                        ? Colors.red
                                        : Colors.grey[800],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                Text(
                                  '${match.awayScore}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: match.status == MatchStatus.live
                                        ? Colors.red
                                        : Colors.grey[800],
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Away Team
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: sportColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                match.awayTeamLogo,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            match.awayTeam,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          const Text(
            'No matches scheduled',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check another date or sport',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  String _getDateTitle() {
    final today = DateTime.now();
    final dateOnly = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final todayOnly = DateTime(today.year, today.month, today.day);

    if (dateOnly.isAtSameMomentAs(todayOnly)) {
      return 'Today\'s Matches';
    } else if (dateOnly.isAtSameMomentAs(
      todayOnly.subtract(const Duration(days: 1)),
    )) {
      return 'Yesterday\'s Matches';
    } else if (dateOnly.isAtSameMomentAs(
      todayOnly.add(const Duration(days: 1)),
    )) {
      return 'Tomorrow\'s Matches';
    } else {
      return DateFormat('EEEE, MMMM d').format(_selectedDate);
    }
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
}
