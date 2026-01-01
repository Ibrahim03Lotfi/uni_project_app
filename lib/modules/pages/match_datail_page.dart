import 'package:flutter/material.dart';

// ==================== MODELS ====================

enum MatchStatus { live, finished, scheduled, postponed }

enum EventType {
  goal,
  ownGoal,
  penalty,
  penaltyMissed,
  yellowCard,
  redCard,
  substitution,
  varDecision,
  halfTime,
  fullTime,
}

class MatchEvent {
  final int minute;
  final int? addedTime;
  final EventType type;
  final String playerName;
  final String? assistName;
  final bool isHomeTeam;
  final String? description;

  MatchEvent({
    required this.minute,
    this.addedTime,
    required this.type,
    required this.playerName,
    this.assistName,
    required this.isHomeTeam,
    this.description,
  });
}

class MatchStatistic {
  final String name;
  final int homeValue;
  final int awayValue;
  final bool isPercentage;

  MatchStatistic({
    required this.name,
    required this.homeValue,
    required this.awayValue,
    this.isPercentage = false,
  });
}

class Player {
  final String name;
  final int number;
  final String position;
  final bool isCaptain;
  final bool isSubstituted;
  final int? substitutedMinute;

  Player({
    required this.name,
    required this.number,
    required this.position,
    this.isCaptain = false,
    this.isSubstituted = false,
    this.substitutedMinute,
  });
}

class TeamLineup {
  final String formation;
  final List<Player> startingXI;
  final List<Player> substitutes;
  final String coach;

  TeamLineup({
    required this.formation,
    required this.startingXI,
    required this.substitutes,
    required this.coach,
  });
}

class MatchData {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final int homeScore;
  final int awayScore;
  final MatchStatus status;
  final String currentTime;
  final String matchDate;
  final String kickoffTime;
  final String stadium;
  final String city;
  final String referee;
  final int? attendance;
  final String league;
  final String leagueLogo;
  final List<MatchEvent> events;
  final List<MatchStatistic> statistics;
  final TeamLineup? homeLineup;
  final TeamLineup? awayLineup;

  MatchData({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.currentTime,
    required this.matchDate,
    required this.kickoffTime,
    required this.stadium,
    required this.city,
    required this.referee,
    this.attendance,
    required this.league,
    required this.leagueLogo,
    required this.events,
    required this.statistics,
    this.homeLineup,
    this.awayLineup,
  });
}

// ==================== MAIN PAGE ====================

class MatchDetailsPage extends StatefulWidget {
  final String matchId;

  const MatchDetailsPage({super.key, required this.matchId});

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage>
    with SingleTickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  late TabController _tabController;
  late MatchData _matchData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _initializeMatchData();
  }

  void _initializeMatchData() {
    _matchData = MatchData(
      id: widget.matchId,
      homeTeam: 'Manchester United',
      awayTeam: 'Liverpool',
      homeTeamLogo: '🔴',
      awayTeamLogo: '🔴',
      homeScore: 2,
      awayScore: 1,
      status: MatchStatus.live,
      currentTime: "75'",
      matchDate: 'Sunday, 15 Dec 2024',
      kickoffTime: '16:30',
      stadium: 'Old Trafford',
      city: 'Manchester, England',
      referee: 'Michael Oliver',
      attendance: 74310,
      league: 'Premier League',
      leagueLogo: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
      events: [
        MatchEvent(
          minute: 12,
          type: EventType.goal,
          playerName: 'Marcus Rashford',
          assistName: 'Bruno Fernandes',
          isHomeTeam: true,
        ),
        MatchEvent(
          minute: 23,
          type: EventType.yellowCard,
          playerName: 'Casemiro',
          isHomeTeam: true,
        ),
        MatchEvent(
          minute: 34,
          type: EventType.goal,
          playerName: 'Mohamed Salah',
          assistName: 'Trent Alexander-Arnold',
          isHomeTeam: false,
        ),
        MatchEvent(
          minute: 45,
          addedTime: 2,
          type: EventType.halfTime,
          playerName: 'Half Time',
          isHomeTeam: true,
        ),
        MatchEvent(
          minute: 56,
          type: EventType.substitution,
          playerName: 'Antony',
          assistName: 'Alejandro Garnacho',
          isHomeTeam: true,
          description: 'Substitution',
        ),
        MatchEvent(
          minute: 67,
          type: EventType.goal,
          playerName: 'Bruno Fernandes',
          isHomeTeam: true,
        ),
        MatchEvent(
          minute: 72,
          type: EventType.yellowCard,
          playerName: 'Virgil van Dijk',
          isHomeTeam: false,
        ),
        MatchEvent(
          minute: 74,
          type: EventType.varDecision,
          playerName: 'VAR Check',
          isHomeTeam: true,
          description: 'Goal confirmed - No offside',
        ),
      ],
      statistics: [
        MatchStatistic(
          name: 'Possession',
          homeValue: 48,
          awayValue: 52,
          isPercentage: true,
        ),
        MatchStatistic(name: 'Total Shots', homeValue: 14, awayValue: 11),
        MatchStatistic(name: 'Shots on Target', homeValue: 6, awayValue: 4),
        MatchStatistic(name: 'Corner Kicks', homeValue: 5, awayValue: 7),
        MatchStatistic(name: 'Fouls', homeValue: 12, awayValue: 9),
        MatchStatistic(name: 'Offsides', homeValue: 2, awayValue: 3),
        MatchStatistic(name: 'Saves', homeValue: 3, awayValue: 4),
        MatchStatistic(name: 'Passes', homeValue: 387, awayValue: 421),
        MatchStatistic(
          name: 'Pass Accuracy',
          homeValue: 84,
          awayValue: 87,
          isPercentage: true,
        ),
        MatchStatistic(name: 'Yellow Cards', homeValue: 1, awayValue: 1),
      ],
      homeLineup: TeamLineup(
        formation: '4-2-3-1',
        startingXI: [
          Player(name: 'André Onana', number: 24, position: 'GK'),
          Player(name: 'Diogo Dalot', number: 20, position: 'RB'),
          Player(name: 'Raphaël Varane', number: 19, position: 'CB'),
          Player(name: 'Lisandro Martínez', number: 6, position: 'CB'),
          Player(name: 'Luke Shaw', number: 23, position: 'LB'),
          Player(name: 'Casemiro', number: 18, position: 'CDM'),
          Player(name: 'Kobbie Mainoo', number: 37, position: 'CDM'),
          Player(
            name: 'Antony',
            number: 21,
            position: 'RW',
            isSubstituted: true,
            substitutedMinute: 56,
          ),
          Player(
            name: 'Bruno Fernandes',
            number: 8,
            position: 'CAM',
            isCaptain: true,
          ),
          Player(name: 'Marcus Rashford', number: 10, position: 'LW'),
          Player(name: 'Rasmus Højlund', number: 11, position: 'ST'),
        ],
        substitutes: [
          Player(name: 'Tom Heaton', number: 22, position: 'GK'),
          Player(name: 'Victor Lindelöf', number: 2, position: 'CB'),
          Player(name: 'Alejandro Garnacho', number: 17, position: 'LW'),
          Player(name: 'Mason Mount', number: 7, position: 'CAM'),
          Player(name: 'Scott McTominay', number: 39, position: 'CM'),
        ],
        coach: 'Erik ten Hag',
      ),
      awayLineup: TeamLineup(
        formation: '4-3-3',
        startingXI: [
          Player(name: 'Alisson Becker', number: 1, position: 'GK'),
          Player(name: 'Trent Alexander-Arnold', number: 66, position: 'RB'),
          Player(
            name: 'Virgil van Dijk',
            number: 4,
            position: 'CB',
            isCaptain: true,
          ),
          Player(name: 'Ibrahima Konaté', number: 5, position: 'CB'),
          Player(name: 'Andrew Robertson', number: 26, position: 'LB'),
          Player(name: 'Alexis Mac Allister', number: 10, position: 'CM'),
          Player(name: 'Dominik Szoboszlai', number: 8, position: 'CM'),
          Player(name: 'Ryan Gravenberch', number: 38, position: 'CM'),
          Player(name: 'Mohamed Salah', number: 11, position: 'RW'),
          Player(name: 'Darwin Núñez', number: 9, position: 'ST'),
          Player(name: 'Luis Díaz', number: 7, position: 'LW'),
        ],
        substitutes: [
          Player(name: 'Caoimhín Kelleher', number: 62, position: 'GK'),
          Player(name: 'Joe Gomez', number: 2, position: 'CB'),
          Player(name: 'Cody Gakpo', number: 18, position: 'LW'),
          Player(name: 'Curtis Jones', number: 17, position: 'CM'),
          Player(name: 'Diogo Jota', number: 20, position: 'ST'),
        ],
        coach: 'Jürgen Klopp',
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        // Left Sidebar - Match Info Summary
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCompactHeader(),
              const Divider(height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildQuickActions(),
                      const SizedBox(height: 24),
                      _buildMatchInfo(),
                      const SizedBox(height: 24),
                      _buildHeadToHead(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Main Content
        Expanded(
          child: Column(
            children: [
              _buildDesktopHeader(),
              _buildDesktopScoreCard(),
              _buildTabBar(isDesktop: true),
              Expanded(child: _buildTabContent(isDesktop: true)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.sports_soccer,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'SportsFeed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 16),
          // League Info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _matchData.leagueLogo,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  _matchData.league,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Match Status
          _buildStatusBadge(large: true),
          const SizedBox(width: 16),
          // Share Button
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopScoreCard() {
    return Container(
      margin: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryGreen, darkGreen],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Home Team
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      _matchData.homeTeamLogo,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _matchData.homeTeam,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_matchData.homeScore}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      '${_matchData.awayScore}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_matchData.status == MatchStatus.live)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _matchData.currentTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    _matchData.status == MatchStatus.finished
                        ? 'Full Time'
                        : _matchData.kickoffTime,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
              ],
            ),
          ),
          // Away Team
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      _matchData.awayTeamLogo,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _matchData.awayTeam,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TABLET LAYOUT ====================
  Widget _buildTabletLayout() {
    return Column(
      children: [
        _buildMobileHeader(),
        _buildMobileScoreCard(),
        _buildTabBar(isDesktop: false),
        Expanded(child: _buildTabContent(isDesktop: false)),
      ],
    );
  }

  // ==================== MOBILE LAYOUT ====================
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMobileHeader(),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildMobileScoreCard()),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: primaryGreen,
                    unselectedLabelColor: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant,
                    indicatorColor: primaryGreen,
                    indicatorWeight: 3,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                    tabs: const [
                      Tab(text: 'Events'),
                      Tab(text: 'Stats'),
                      Tab(text: 'Lineups'),
                      Tab(text: 'Table'),
                      Tab(text: 'Info'),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEventsSection(),
                    _buildStatsSection(),
                    _buildLineupsSection(),
                    _buildTableSection(),
                    _buildInfoSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _matchData.leagueLogo,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _matchData.league,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _matchData.matchDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(large: false),
        ],
      ),
    );
  }

  Widget _buildMobileScoreCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryGreen, darkGreen],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Teams and Score
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          _matchData.homeTeamLogo,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _matchData.homeTeam,
                      style: const TextStyle(
                        color: Colors.white,
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
              // Score
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_matchData.homeScore}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '-',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Text(
                          '${_matchData.awayScore}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (_matchData.status == MatchStatus.live)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _matchData.currentTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Text(
                        _matchData.status == MatchStatus.finished
                            ? 'Full Time'
                            : _matchData.kickoffTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          _matchData.awayTeamLogo,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _matchData.awayTeam,
                      style: const TextStyle(
                        color: Colors.white,
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
          const SizedBox(height: 16),
          // Goal Scorers
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Home Goals
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _matchData.events
                        .where((e) => e.isHomeTeam && e.type == EventType.goal)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              "${e.playerName} ${e.minute}'",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white24),
                // Away Goals
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _matchData.events
                        .where((e) => !e.isHomeTeam && e.type == EventType.goal)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              "${e.minute}' ${e.playerName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge({required bool large}) {
    Color bgColor;
    Color textColor;
    String statusText;
    bool showPulse = false;

    switch (_matchData.status) {
      case MatchStatus.live:
        bgColor = Colors.red[50]!;
        textColor = Colors.red[700]!;
        statusText = 'LIVE';
        showPulse = true;
        break;
      case MatchStatus.finished:
        bgColor = Theme.of(context).colorScheme.surfaceVariant;
        textColor = Theme.of(context).colorScheme.onSurfaceVariant;
        statusText = 'FT';
        break;
      case MatchStatus.scheduled:
        bgColor = primaryGreen.withOpacity(0.1);
        textColor = primaryGreen;
        statusText = 'Scheduled';
        break;
      case MatchStatus.postponed:
        bgColor = Colors.orange[50]!;
        textColor = Colors.orange[700]!;
        statusText = 'Postponed';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 16 : 12,
        vertical: large ? 8 : 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPulse) ...[
            _PulsingDot(color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: large ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar({required bool isDesktop}) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: TabBar(
        controller: _tabController,
        labelColor: primaryGreen,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        indicatorColor: primaryGreen,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Events'),
          Tab(text: 'Stats'),
          Tab(text: 'Lineups'),
          Tab(text: 'Table'),
          Tab(text: 'Info'),
        ],
      ),
    );
  }

  Widget _buildTabContent({required bool isDesktop}) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildEventsSection(),
        _buildStatsSection(),
        _buildLineupsSection(),
        _buildTableSection(),
        _buildInfoSection(),
      ],
    );
  }

  // ==================== EVENTS SECTION ====================
  Widget _buildEventsSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _matchData.events.length,
      itemBuilder: (context, index) {
        final event = _matchData.events[index];
        return _buildEventItem(event);
      },
    );
  }

  Widget _buildEventItem(MatchEvent event) {
    final isSpecialEvent =
        event.type == EventType.halfTime || event.type == EventType.fullTime;

    if (isSpecialEvent) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                event.playerName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Time
          SizedBox(
            width: 50,
            child: Text(
              "${event.minute}'${event.addedTime != null ? '+${event.addedTime}' : ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          // Event Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getEventColor(event.type).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(child: _getEventIcon(event.type)),
          ),
          const SizedBox(width: 12),
          // Event Details
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Row(
                children: [
                  if (!event.isHomeTeam) const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: event.isHomeTeam
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Text(
                          event.playerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (event.assistName != null)
                          Text(
                            event.type == EventType.substitution
                                ? '↔ ${event.assistName}'
                                : 'Assist: ${event.assistName}',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        if (event.description != null)
                          Text(
                            event.description!,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (event.isHomeTeam) const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEventColor(EventType type) {
    switch (type) {
      case EventType.goal:
      case EventType.penalty:
        return primaryGreen;
      case EventType.ownGoal:
        return Colors.red[700]!;
      case EventType.yellowCard:
        return Colors.amber[600]!;
      case EventType.redCard:
        return Colors.red[700]!;
      case EventType.substitution:
        return Colors.blue[600]!;
      case EventType.varDecision:
        return Colors.purple[600]!;
      case EventType.penaltyMissed:
        return Colors.red[400]!;
      default:
        return Colors.grey;
    }
  }

  Widget _getEventIcon(EventType type) {
    IconData icon;
    Color color = _getEventColor(type);

    switch (type) {
      case EventType.goal:
      case EventType.penalty:
        icon = Icons.sports_soccer;
        break;
      case EventType.ownGoal:
        icon = Icons.sports_soccer;
        break;
      case EventType.yellowCard:
        return Container(
          width: 16,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.amber[600],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      case EventType.redCard:
        return Container(
          width: 16,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.red[700],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      case EventType.substitution:
        icon = Icons.swap_horiz;
        break;
      case EventType.varDecision:
        icon = Icons.tv;
        break;
      case EventType.penaltyMissed:
        icon = Icons.cancel_outlined;
        break;
      default:
        icon = Icons.info_outline;
    }

    return Icon(icon, color: color, size: 20);
  }

  // ==================== STATS SECTION ====================
  Widget _buildStatsSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _matchData.statistics.length,
      itemBuilder: (context, index) {
        final stat = _matchData.statistics[index];
        return _buildStatItem(stat);
      },
    );
  }

  Widget _buildStatItem(MatchStatistic stat) {
    final total = stat.homeValue + stat.awayValue;
    final homePercentage = total > 0 ? stat.homeValue / total : 0.5;
    final awayPercentage = total > 0 ? stat.awayValue / total : 0.5;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Values Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat.isPercentage ? '${stat.homeValue}%' : '${stat.homeValue}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: homePercentage >= awayPercentage
                      ? primaryGreen
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                stat.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                stat.isPercentage ? '${stat.awayValue}%' : '${stat.awayValue}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: awayPercentage > homePercentage
                      ? primaryGreen
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Row(
            children: [
              Expanded(
                flex: (homePercentage * 100).round(),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: homePercentage >= awayPercentage
                        ? primaryGreen
                        : primaryGreen.withOpacity(0.3),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: (awayPercentage * 100).round(),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: awayPercentage > homePercentage
                        ? primaryGreen
                        : primaryGreen.withOpacity(0.3),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== LINEUPS SECTION ====================
  Widget _buildLineupsSection() {
    if (_matchData.homeLineup == null || _matchData.awayLineup == null) {
      return const Center(child: Text('Lineups not available'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Formation Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      _matchData.homeLineup!.formation,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    Text(
                      _matchData.homeTeam,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Formation',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _matchData.awayLineup!.formation,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    Text(
                      _matchData.awayTeam,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Football Pitch
          _buildFootballPitch(),
          const SizedBox(height: 24),
          // Starting XI Lists
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTeamLineupList(
                  _matchData.homeLineup!,
                  _matchData.homeTeam,
                  true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTeamLineupList(
                  _matchData.awayLineup!,
                  _matchData.awayTeam,
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFootballPitch() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green[700]!, Colors.green[600]!, Colors.green[700]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Pitch Lines
          CustomPaint(
            size: const Size(double.infinity, 400),
            painter: PitchPainter(),
          ),
          // Home Team Players (Top Half)
          Positioned.fill(
            top: 0,
            bottom: 200,
            child: _buildFormationPlayers(_matchData.homeLineup!, true),
          ),
          // Away Team Players (Bottom Half)
          Positioned.fill(
            top: 200,
            bottom: 0,
            child: _buildFormationPlayers(_matchData.awayLineup!, false),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationPlayers(TeamLineup lineup, bool isHome) {
    // Parse formation (e.g., "4-3-3" -> [4, 3, 3])
    final formationParts = lineup.formation.split('-').map(int.parse).toList();
    final totalRows = formationParts.length + 1; // +1 for goalkeeper

    return LayoutBuilder(
      builder: (context, constraints) {
        final rowHeight = constraints.maxHeight / totalRows;

        List<Widget> rows = [];

        // Add goalkeeper
        rows.add(
          Positioned(
            top: isHome ? 10 : null,
            bottom: isHome ? null : 10,
            left: 0,
            right: 0,
            child: Center(
              child: _buildPlayerDot(
                lineup.startingXI.firstWhere((p) => p.position == 'GK'),
                isHome,
              ),
            ),
          ),
        );

        // Add outfield players by formation rows
        int playerIndex = 1; // Start after goalkeeper
        for (int i = 0; i < formationParts.length; i++) {
          final playersInRow =
              formationParts[isHome ? i : formationParts.length - 1 - i];
          final rowPlayers = <Widget>[];

          for (
            int j = 0;
            j < playersInRow && playerIndex < lineup.startingXI.length;
            j++
          ) {
            rowPlayers.add(
              _buildPlayerDot(lineup.startingXI[playerIndex], isHome),
            );
            playerIndex++;
          }

          final rowPosition = isHome
              ? (i + 1) * rowHeight + 20
              : constraints.maxHeight - (i + 2) * rowHeight;

          rows.add(
            Positioned(
              top: isHome ? rowPosition : null,
              bottom: isHome ? null : constraints.maxHeight - rowPosition - 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: rowPlayers,
              ),
            ),
          );
        }

        return Stack(children: rows);
      },
    );
  }

  Widget _buildPlayerDot(Player player, bool isHome) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isHome ? Colors.red[700] : Colors.blue[700],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${player.number}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            player.name.split(' ').last,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamLineupList(TeamLineup lineup, String teamName, bool isHome) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isHome ? Colors.red[100] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    isHome ? _matchData.homeTeamLogo : _matchData.awayTeamLogo,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  teamName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Coach: ${lineup.coach}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Starting XI',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: primaryGreen,
            ),
          ),
          const SizedBox(height: 8),
          ...lineup.startingXI.map((player) => _buildPlayerRow(player)),
          const SizedBox(height: 16),
          const Text(
            'Substitutes',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: primaryGreen,
            ),
          ),
          const SizedBox(height: 8),
          ...lineup.substitutes.map((player) => _buildPlayerRow(player)),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(Player player) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${player.number}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              player.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: player.isCaptain
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (player.isCaptain)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'C',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          if (player.isSubstituted)
            Row(
              children: [
                const Icon(Icons.arrow_downward, size: 14, color: Colors.red),
                Text(
                  "${player.substitutedMinute}'",
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ==================== TABLE SECTION ====================
  Widget _buildTableSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'League Table',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'View the current standings in ${_matchData.league}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('View Full Table'),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== INFO SECTION ====================
  Widget _buildInfoSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoCard('Match Information', [
            _buildInfoRow(Icons.calendar_today, 'Date', _matchData.matchDate),
            _buildInfoRow(Icons.access_time, 'Kickoff', _matchData.kickoffTime),
            _buildInfoRow(Icons.emoji_events, 'Competition', _matchData.league),
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Venue', [
            _buildInfoRow(Icons.stadium, 'Stadium', _matchData.stadium),
            _buildInfoRow(Icons.location_on, 'City', _matchData.city),
            if (_matchData.attendance != null)
              _buildInfoRow(
                Icons.people,
                'Attendance',
                '${_matchData.attendance!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} fans',
              ),
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Officials', [
            _buildInfoRow(Icons.sports, 'Referee', _matchData.referee),
          ]),
          const SizedBox(height: 24),
          // Head to Head Button
          _buildHeadToHeadButton(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: primaryGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadToHeadButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryGreen.withOpacity(0.1), lightGreen.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _matchData.homeTeamLogo,
                style: const TextStyle(fontSize: 32),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'vs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ),
              Text(
                _matchData.awayTeamLogo,
                style: const TextStyle(fontSize: 32),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Head to Head',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'View previous encounters between these teams',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history, size: 20),
                SizedBox(width: 8),
                Text(
                  'View H2H History',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SIDEBAR WIDGETS ====================
  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            Icons.notifications_outlined,
            'Alerts',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildQuickActionButton(Icons.share_outlined, 'Share')),
        const SizedBox(width: 12),
        Expanded(child: _buildQuickActionButton(Icons.star_outline, 'Save')),
      ],
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildMiniInfoRow(Icons.calendar_today, _matchData.matchDate),
          const SizedBox(height: 12),
          _buildMiniInfoRow(Icons.access_time, _matchData.kickoffTime),
          const SizedBox(height: 12),
          _buildMiniInfoRow(Icons.stadium, _matchData.stadium),
          const SizedBox(height: 12),
          _buildMiniInfoRow(Icons.sports, _matchData.referee),
        ],
      ),
    );
  }

  Widget _buildMiniInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: primaryGreen),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }

  Widget _buildHeadToHead() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryGreen.withOpacity(0.1), lightGreen.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          const Text(
            'Head to Head',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildH2HItem('5', 'MUN Wins'),
              Container(
                width: 1,
                height: 30,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              _buildH2HItem('3', 'Draws'),
              Container(
                width: 1,
                height: 30,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              _buildH2HItem('4', 'LIV Wins'),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text(
              'View All Matches →',
              style: TextStyle(color: primaryGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildH2HItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ==================== HELPER WIDGETS ====================

class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.5 + _controller.value * 0.5),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

// ==================== PITCH PAINTER ====================

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Center circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, paint);

    // Center dot
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 4, dotPaint);

    // Top penalty area
    canvas.drawRect(
      Rect.fromLTWH(size.width / 4, 0, size.width / 2, size.height * 0.15),
      paint,
    );

    // Bottom penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 4,
        size.height * 0.85,
        size.width / 2,
        size.height * 0.15,
      ),
      paint,
    );

    // Top goal area
    canvas.drawRect(
      Rect.fromLTWH(size.width / 3, 0, size.width / 3, size.height * 0.06),
      paint,
    );

    // Bottom goal area
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 3,
        size.height * 0.94,
        size.width / 3,
        size.height * 0.06,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
