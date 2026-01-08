import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports_news_app/modules/pages/follow_teams_page.dart';
import 'package:sports_news_app/services/api_service.dart';

// League Model
class League {
  final String id;
  final String name;
  final String country;
  final String logoEmoji;
  final SportType sport;
  final String? description;
  final String? gender;
  bool isFollowing;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logoEmoji,
    required this.sport,
    this.description,
    this.gender,
    this.isFollowing = false,
  });
}

enum SportType { football, basketball, tennis, volleyball }

class FollowLeaguesPage extends StatefulWidget {
  final List<int> selectedSportIds;
  const FollowLeaguesPage({super.key, required this.selectedSportIds});

  @override
  State<FollowLeaguesPage> createState() => _FollowLeaguesPageState();
}

class _FollowLeaguesPageState extends State<FollowLeaguesPage>
    with SingleTickerProviderStateMixin {
  // Add to your FollowLeaguesPage state class
  List<dynamic> _leagues = [];
  Set<int> _selectedLeagueIds = {};

  Future<void> _fetchLeagues() async {
    try {
      // Replace with your actual endpoint
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/leagues'),
        headers: await ApiService.headers,
      );

      if (response.statusCode == 200) {
        setState(() {
          _leagues = json.decode(response.body)['data'];
        });
      }
    } catch (e) {
      print('Error fetching leagues: $e');
    }
  }

  void _onFinish() async {
    try {
      await ApiService.saveLeaguesPreferences(_selectedLeagueIds.toList());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save league preferences')),
      );
    }

    // Navigate to teams selection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FollowTeamsPage(selectedLeagueIds: _selectedLeagueIds.toList()),
      ),
    );
  }

  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<League> _allLeagues = [];
  Set<String> _followedLeagueIds = {};

  @override
  void initState() {
    super.initState();
    _fetchLeagues();
    _tabController = TabController(length: 5, vsync: this);
    _initializeLeagues();
  }

  void _initializeLeagues() {
    _allLeagues = [
      // ==================== FOOTBALL LEAGUES (10) ====================
      League(
        id: 'epl',
        name: 'English Premier League',
        country: 'England',
        logoEmoji: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
        sport: SportType.football,
        description: 'Top tier English football league',
      ),
      League(
        id: 'la_liga',
        name: 'La Liga',
        country: 'Spain',
        logoEmoji: '🇪🇸',
        sport: SportType.football,
        description: 'Top tier Spanish football league',
      ),
      League(
        id: 'bundesliga',
        name: 'Bundesliga',
        country: 'Germany',
        logoEmoji: '🇩🇪',
        sport: SportType.football,
        description: 'Top tier German football league',
      ),
      League(
        id: 'serie_a',
        name: 'Serie A',
        country: 'Italy',
        logoEmoji: '🇮🇹',
        sport: SportType.football,
        description: 'Top tier Italian football league',
      ),
      League(
        id: 'ligue_1',
        name: 'Ligue 1',
        country: 'France',
        logoEmoji: '🇫🇷',
        sport: SportType.football,
        description: 'Top tier French football league',
      ),
      League(
        id: 'mls',
        name: 'Major League Soccer (MLS)',
        country: 'USA/Canada',
        logoEmoji: '🇺🇸',
        sport: SportType.football,
        description: 'Top tier North American football league',
      ),
      League(
        id: 'brasileirao',
        name: 'Brasileirão Série A',
        country: 'Brazil',
        logoEmoji: '🇧🇷',
        sport: SportType.football,
        description: 'Top tier Brazilian football league',
      ),
      League(
        id: 'liga_mx',
        name: 'Liga MX',
        country: 'Mexico',
        logoEmoji: '🇲🇽',
        sport: SportType.football,
        description: 'Top tier Mexican football league',
      ),
      League(
        id: 'saudi_pro',
        name: 'Saudi Pro League',
        country: 'Saudi Arabia',
        logoEmoji: '🇸🇦',
        sport: SportType.football,
        description: 'Top tier Saudi Arabian football league',
      ),
      League(
        id: 'eredivisie',
        name: 'Eredivisie',
        country: 'Netherlands',
        logoEmoji: '🇳🇱',
        sport: SportType.football,
        description: 'Top tier Dutch football league',
      ),

      // ==================== BASKETBALL LEAGUES (10) ====================
      League(
        id: 'nba',
        name: 'NBA',
        country: 'USA/Canada',
        logoEmoji: '🇺🇸',
        sport: SportType.basketball,
        description: 'National Basketball Association',
      ),
      League(
        id: 'euroleague',
        name: 'EuroLeague',
        country: 'Europe',
        logoEmoji: '🇪🇺',
        sport: SportType.basketball,
        description: 'Premier European basketball competition',
      ),
      League(
        id: 'liga_acb',
        name: 'Liga ACB',
        country: 'Spain',
        logoEmoji: '🇪🇸',
        sport: SportType.basketball,
        description: 'Top tier Spanish basketball league',
      ),
      League(
        id: 'cba',
        name: 'CBA - Chinese Basketball Association',
        country: 'China',
        logoEmoji: '🇨🇳',
        sport: SportType.basketball,
        description: 'Top tier Chinese basketball league',
      ),
      League(
        id: 'nbl_australia',
        name: 'NBL - National Basketball League',
        country: 'Australia',
        logoEmoji: '🇦🇺',
        sport: SportType.basketball,
        description: 'Top tier Australian basketball league',
      ),
      League(
        id: 'bcl',
        name: 'Basketball Champions League',
        country: 'Europe',
        logoEmoji: '🏆',
        sport: SportType.basketball,
        description: 'European basketball club competition',
      ),
      League(
        id: 'vtb',
        name: 'VTB United League',
        country: 'Eastern Europe',
        logoEmoji: '🌍',
        sport: SportType.basketball,
        description: 'Eastern European basketball league',
      ),
      League(
        id: 'bsl_turkey',
        name: 'BSL - Basketball Super League',
        country: 'Turkey',
        logoEmoji: '🇹🇷',
        sport: SportType.basketball,
        description: 'Top tier Turkish basketball league',
      ),
      League(
        id: 'lnb_pro_a',
        name: 'LNB Pro A',
        country: 'France',
        logoEmoji: '🇫🇷',
        sport: SportType.basketball,
        description: 'Top tier French basketball league',
      ),
      League(
        id: 'kbl',
        name: 'KBL - Korean Basketball League',
        country: 'South Korea',
        logoEmoji: '🇰🇷',
        sport: SportType.basketball,
        description: 'Top tier South Korean basketball league',
      ),

      // ==================== VOLLEYBALL LEAGUES (10) ====================
      League(
        id: 'italy_serie_a1_men',
        name: 'Italian Serie A1',
        country: 'Italy',
        logoEmoji: '🇮🇹',
        sport: SportType.volleyball,
        description: 'Top tier Italian volleyball league',
        gender: 'Men',
      ),
      League(
        id: 'italy_serie_a1_women',
        name: 'Italian Serie A1',
        country: 'Italy',
        logoEmoji: '🇮🇹',
        sport: SportType.volleyball,
        description: 'Top tier Italian volleyball league',
        gender: 'Women',
      ),
      League(
        id: 'plusliga',
        name: 'Polish PlusLiga',
        country: 'Poland',
        logoEmoji: '🇵🇱',
        sport: SportType.volleyball,
        description: 'Top tier Polish volleyball league',
        gender: 'Men',
      ),
      League(
        id: 'superliga_brazil',
        name: 'Brazilian Superliga',
        country: 'Brazil',
        logoEmoji: '🇧🇷',
        sport: SportType.volleyball,
        description: 'Top tier Brazilian volleyball league',
        gender: 'Men & Women',
      ),
      League(
        id: 'sultanlar_ligi',
        name: 'Turkish Sultanlar Ligi',
        country: 'Turkey',
        logoEmoji: '🇹🇷',
        sport: SportType.volleyball,
        description: 'Top tier Turkish women\'s volleyball league',
        gender: 'Women',
      ),
      League(
        id: 'russian_super_league',
        name: 'Russian Super League',
        country: 'Russia',
        logoEmoji: '🇷🇺',
        sport: SportType.volleyball,
        description: 'Top tier Russian volleyball league',
        gender: 'Men',
      ),
      League(
        id: 'v_league_japan',
        name: 'Japanese V.League',
        country: 'Japan',
        logoEmoji: '🇯🇵',
        sport: SportType.volleyball,
        description: 'Top tier Japanese volleyball league',
        gender: 'Men & Women',
      ),
      League(
        id: 'efeler_ligi',
        name: 'Turkish Efeler Ligi',
        country: 'Turkey',
        logoEmoji: '🇹🇷',
        sport: SportType.volleyball,
        description: 'Top tier Turkish men\'s volleyball league',
        gender: 'Men',
      ),
      League(
        id: 'bundesliga_volleyball',
        name: 'German Bundesliga',
        country: 'Germany',
        logoEmoji: '🇩🇪',
        sport: SportType.volleyball,
        description: 'Top tier German volleyball league',
        gender: 'Men & Women',
      ),
      League(
        id: 'ligue_a_france',
        name: 'French Ligue A',
        country: 'France',
        logoEmoji: '🇫🇷',
        sport: SportType.volleyball,
        description: 'Top tier French volleyball league',
        gender: 'Men',
      ),

      // ==================== TENNIS LEAGUES/TOURNAMENTS (14) ====================
      // Professional Tours
      League(
        id: 'atp_tour',
        name: 'ATP Tour',
        country: 'International',
        logoEmoji: '🎾',
        sport: SportType.tennis,
        description: 'Men\'s professional tennis tour',
        gender: 'Men',
      ),
      League(
        id: 'wta_tour',
        name: 'WTA Tour',
        country: 'International',
        logoEmoji: '🎾',
        sport: SportType.tennis,
        description: 'Women\'s professional tennis tour',
        gender: 'Women',
      ),
      League(
        id: 'atp_challenger',
        name: 'ATP Challenger Tour',
        country: 'International',
        logoEmoji: '🎾',
        sport: SportType.tennis,
        description: 'Second-tier men\'s professional tour',
        gender: 'Men',
      ),
      League(
        id: 'itf_world_tour',
        name: 'ITF World Tennis Tour',
        country: 'International',
        logoEmoji: '🌍',
        sport: SportType.tennis,
        description: 'Entry-level professional tour',
        gender: 'Men & Women',
      ),

      // Grand Slams
      League(
        id: 'australian_open',
        name: 'Australian Open',
        country: 'Australia',
        logoEmoji: '🇦🇺',
        sport: SportType.tennis,
        description: 'First Grand Slam of the year',
      ),
      League(
        id: 'roland_garros',
        name: 'Roland Garros (French Open)',
        country: 'France',
        logoEmoji: '🇫🇷',
        sport: SportType.tennis,
        description: 'Clay court Grand Slam',
      ),
      League(
        id: 'wimbledon',
        name: 'Wimbledon',
        country: 'England',
        logoEmoji: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
        sport: SportType.tennis,
        description: 'Oldest tennis tournament - Grass court',
      ),
      League(
        id: 'us_open',
        name: 'US Open',
        country: 'USA',
        logoEmoji: '🇺🇸',
        sport: SportType.tennis,
        description: 'Final Grand Slam of the year',
      ),

      // Team Competitions & Special Events
      League(
        id: 'united_cup',
        name: 'United Cup',
        country: 'International',
        logoEmoji: '🏆',
        sport: SportType.tennis,
        description: 'Mixed team tennis competition',
        gender: 'Mixed',
      ),
      League(
        id: 'davis_cup',
        name: 'Davis Cup',
        country: 'International',
        logoEmoji: '🏆',
        sport: SportType.tennis,
        description: 'Men\'s national team competition',
        gender: 'Men',
      ),
      League(
        id: 'billie_jean_king_cup',
        name: 'Billie Jean King Cup',
        country: 'International',
        logoEmoji: '🏆',
        sport: SportType.tennis,
        description: 'Women\'s national team competition',
        gender: 'Women',
      ),
      League(
        id: 'laver_cup',
        name: 'Laver Cup',
        country: 'International',
        logoEmoji: '⭐',
        sport: SportType.tennis,
        description: 'Team Europe vs Team World',
        gender: 'Men',
      ),
      League(
        id: 'next_gen_atp',
        name: 'Next Gen ATP Finals',
        country: 'International',
        logoEmoji: '🌟',
        sport: SportType.tennis,
        description: 'U-21 year-end championship',
        gender: 'Men',
      ),
    ];
  }

  List<League> get _filteredLeagues {
    if (_searchQuery.isEmpty) {
      return _allLeagues;
    }
    return _allLeagues.where((league) {
      return league.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          league.country.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          league.sport.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (league.description?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false) ||
          (league.gender?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
    }).toList();
  }

  List<League> get _footballLeagues =>
      _filteredLeagues.where((l) => l.sport == SportType.football).toList();

  List<League> get _basketballLeagues =>
      _filteredLeagues.where((l) => l.sport == SportType.basketball).toList();

  List<League> get _tennisLeagues =>
      _filteredLeagues.where((l) => l.sport == SportType.tennis).toList();

  List<League> get _volleyballLeagues =>
      _filteredLeagues.where((l) => l.sport == SportType.volleyball).toList();

  void _toggleFollow(League league) {
    setState(() {
      if (_followedLeagueIds.contains(league.id)) {
        _followedLeagueIds.remove(league.id);
        league.isFollowing = false;
      } else {
        _followedLeagueIds.add(league.id);
        league.isFollowing = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _buildResponsiveLayout(constraints, scheme);
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(
    BoxConstraints constraints,
    ColorScheme scheme,
  ) {
    final width = constraints.maxWidth;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    if (isDesktop) {
      return _buildDesktopLayout(scheme);
    } else if (isTablet) {
      return _buildTabletLayout(scheme);
    } else {
      return _buildMobileLayout(scheme);
    }
  }

  // ==================== DESKTOP LAYOUT ====================
  Widget _buildDesktopLayout(ColorScheme scheme) {
    return Row(
      children: [
        _buildDesktopSidebar(scheme),
        Expanded(
          child: Column(
            children: [
              _buildDesktopHeader(scheme),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _buildMainContent(scheme, isDesktop: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSidebar(ColorScheme scheme) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
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
                Text(
                  'SportsFeed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          // Onboarding Progress
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setup Progress',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _buildProgressItem('Choose Sports', true, 1, scheme: scheme),
                _buildProgressItem(
                  'Select Leagues',
                  false,
                  2,
                  isActive: true,
                  scheme: scheme,
                ),
                _buildProgressItem('Follow Teams', false, 3, scheme: scheme),
                _buildProgressItem('Follow Players', false, 4, scheme: scheme),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          // Sports Quick Stats
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Following by Sport',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSportStatRow(
                  Icons.sports_soccer,
                  'Football',
                  _footballLeagues
                      .where((l) => _followedLeagueIds.contains(l.id))
                      .length,
                  _footballLeagues.length,
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_basketball,
                  'Basketball',
                  _basketballLeagues
                      .where((l) => _followedLeagueIds.contains(l.id))
                      .length,
                  _basketballLeagues.length,
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_tennis,
                  'Tennis',
                  _tennisLeagues
                      .where((l) => _followedLeagueIds.contains(l.id))
                      .length,
                  _tennisLeagues.length,
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_volleyball,
                  'Volleyball',
                  _volleyballLeagues
                      .where((l) => _followedLeagueIds.contains(l.id))
                      .length,
                  _volleyballLeagues.length,
                  scheme: scheme,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Following Summary
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
                Icon(
                  Icons.emoji_events_outlined,
                  color: primaryGreen,
                  size: 40,
                ),
                const SizedBox(height: 12),
                Text(
                  '${_followedLeagueIds.length}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
                Text(
                  'Leagues Following',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportStatRow(
    IconData icon,
    String sport,
    int following,
    int total, {
    required ColorScheme scheme,
  }) {
    final sportColor = _getSportColorByName(sport);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: sportColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: sportColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sport,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$following of $total',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: following > 0
                  ? primaryGreen.withOpacity(0.1)
                  : scheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$following',
              style: TextStyle(
                color: following > 0 ? primaryGreen : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSportColorByName(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return primaryGreen;
      case 'basketball':
        return Colors.orange[700]!;
      case 'tennis':
        return Colors.yellow[800]!;
      case 'volleyball':
        return Colors.blue[700]!;
      default:
        return primaryGreen;
    }
  }

  Widget _buildProgressItem(
    String title,
    bool isCompleted,
    int step, {
    bool isActive = false,
    required ColorScheme scheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted
                  ? primaryGreen
                  : isActive
                  ? primaryGreen.withOpacity(0.2)
                  : scheme.surfaceVariant,
              shape: BoxShape.circle,
              border: isActive
                  ? Border.all(color: primaryGreen, width: 2)
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '$step',
                      style: TextStyle(
                        color: isActive
                            ? primaryGreen
                            : scheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? primaryGreen : scheme.onSurfaceVariant,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Current',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: scheme.surface,
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
          Expanded(child: _buildSearchBar(scheme, isDesktop: true)),
          const SizedBox(width: 24),
          _buildFollowingChip(scheme),
          const SizedBox(width: 16),
          _buildContinueButton(scheme),
        ],
      ),
    );
  }

  // ==================== TABLET LAYOUT ====================
  Widget _buildTabletLayout(ColorScheme scheme) {
    return Column(
      children: [
        _buildMobileHeader(scheme),
        _buildSearchBar(scheme, isDesktop: false),
        _buildTabBar(scheme),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildTabContent(scheme, crossAxisCount: 2),
          ),
        ),
        _buildBottomBar(scheme),
      ],
    );
  }

  // ==================== MOBILE LAYOUT ====================
  Widget _buildMobileLayout(ColorScheme scheme) {
    return Column(
      children: [
        _buildMobileHeader(scheme),
        _buildSearchBar(scheme, isDesktop: false),
        _buildTabBar(scheme),
        Expanded(child: _buildTabContent(scheme, crossAxisCount: 1)),
        _buildBottomBar(scheme),
      ],
    );
  }

  Widget _buildMobileHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: scheme.onSurface),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Leagues',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              _buildFollowingChip(scheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme scheme, {required bool isDesktop}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 0 : 20,
        vertical: isDesktop ? 0 : 16,
      ),
      color: isDesktop ? Colors.transparent : scheme.surface,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search leagues, countries, or sports...',
            hintStyle: TextStyle(color: scheme.onSurfaceVariant),
            prefixIcon: Icon(Icons.search, color: scheme.onSurfaceVariant),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: scheme.onSurfaceVariant),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFollowingChip(ColorScheme scheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _followedLeagueIds.isNotEmpty
            ? primaryGreen.withOpacity(0.1)
            : scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _followedLeagueIds.isNotEmpty
              ? primaryGreen.withOpacity(0.3)
              : scheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _followedLeagueIds.isNotEmpty
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: _followedLeagueIds.isNotEmpty
                ? primaryGreen
                : scheme.onSurfaceVariant,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            '${_followedLeagueIds.length} Following',
            style: TextStyle(
              color: _followedLeagueIds.isNotEmpty
                  ? primaryGreen
                  : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(ColorScheme scheme) {
    return ElevatedButton(
      onPressed: _followedLeagueIds.isNotEmpty
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FollowTeamsPage(
                    selectedLeagueIds: _selectedLeagueIds.toList(),
                  ),
                ),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: scheme.surfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Continue',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 20),
        ],
      ),
    );
  }

  Widget _buildTabBar(ColorScheme scheme) {
    return Container(
      color: scheme.surface,
      child: TabBar(
        controller: _tabController,
        labelColor: primaryGreen,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: primaryGreen,
        indicatorWeight: 3,
        isScrollable: true,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabAlignment: TabAlignment.start,
        tabs: [
          _buildTabItem(Icons.sports, 'All', _filteredLeagues.length, scheme),
          _buildTabItem(
            Icons.sports_soccer,
            'Football',
            _footballLeagues.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_basketball,
            'Basketball',
            _basketballLeagues.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_tennis,
            'Tennis',
            _tennisLeagues.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_volleyball,
            'Volleyball',
            _volleyballLeagues.length,
            scheme,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    IconData icon,
    String label,
    int count,
    ColorScheme scheme,
  ) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
          if (count > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(fontSize: 12, color: scheme.onSurface),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent(ColorScheme scheme, {required bool isDesktop}) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
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
          // Header
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
                  child: Icon(
                    Icons.emoji_events_outlined,
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
                        'Follow Your Favorite Leagues',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Select leagues to get personalized news and updates',
                        style: TextStyle(
                          fontSize: 14,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: scheme.onSurfaceVariant,
                  indicator: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  padding: const EdgeInsets.all(4),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Football'),
                    Tab(text: 'Basketball'),
                    Tab(text: 'Tennis'),
                    Tab(text: 'Volleyball'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLeaguesList(
                  _filteredLeagues,
                  scheme,
                  isDesktop: isDesktop,
                ),
                _buildLeaguesList(
                  _footballLeagues,
                  scheme,
                  isDesktop: isDesktop,
                ),
                _buildLeaguesList(
                  _basketballLeagues,
                  scheme,
                  isDesktop: isDesktop,
                ),
                _buildLeaguesList(_tennisLeagues, scheme, isDesktop: isDesktop),
                _buildLeaguesList(
                  _volleyballLeagues,
                  scheme,
                  isDesktop: isDesktop,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(ColorScheme scheme, {required int crossAxisCount}) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildLeaguesGrid(
          _filteredLeagues,
          scheme,
          crossAxisCount: crossAxisCount,
        ),
        _buildLeaguesGrid(
          _footballLeagues,
          scheme,
          crossAxisCount: crossAxisCount,
        ),
        _buildLeaguesGrid(
          _basketballLeagues,
          scheme,
          crossAxisCount: crossAxisCount,
        ),
        _buildLeaguesGrid(
          _tennisLeagues,
          scheme,
          crossAxisCount: crossAxisCount,
        ),
        _buildLeaguesGrid(
          _volleyballLeagues,
          scheme,
          crossAxisCount: crossAxisCount,
        ),
      ],
    );
  }

  Widget _buildLeaguesList(
    List<League> leagues,
    ColorScheme scheme, {
    required bool isDesktop,
  }) {
    if (leagues.isEmpty) {
      return _buildEmptyState(scheme);
    }

    // Group leagues by country
    Map<String, List<League>> groupedLeagues = {};
    for (var league in leagues) {
      groupedLeagues.putIfAbsent(league.country, () => []).add(league);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: groupedLeagues.length,
      itemBuilder: (context, index) {
        String groupName = groupedLeagues.keys.elementAt(index);
        List<League> groupLeagues = groupedLeagues[groupName]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) const SizedBox(height: 24),
            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: primaryGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          groupName,
                          style: TextStyle(
                            color: primaryGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(height: 1, color: scheme.outlineVariant),
                  ),
                ],
              ),
            ),
            // Leagues Grid
            if (isDesktop)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: groupLeagues.map((league) {
                  return SizedBox(
                    width: 360,
                    child: _buildLeagueCard(league, scheme),
                  );
                }).toList(),
              )
            else
              ...groupLeagues.map(
                (league) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildLeagueCard(league, scheme),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLeaguesGrid(
    List<League> leagues,
    ColorScheme scheme, {
    required int crossAxisCount,
  }) {
    if (leagues.isEmpty) {
      return _buildEmptyState(scheme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildLeagueCard(leagues[index], scheme),
        );
      },
    );
  }

  Widget _buildLeagueCard(League league, ColorScheme scheme) {
    final isFollowing = _followedLeagueIds.contains(league.id);
    final sportColor = _getSportColor(league.sport);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFollowing ? sportColor : scheme.outlineVariant,
          width: isFollowing ? 2 : 1,
        ),
        boxShadow: isFollowing
            ? [
                BoxShadow(
                  color: sportColor.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleFollow(league),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // League Logo
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: sportColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sportColor.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      league.logoEmoji,
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
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                league.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isFollowing
                                      ? sportColor
                                      : scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildSportBadge(league.sport, scheme),
                          if (league.gender != null)
                            _buildGenderBadge(league.gender!, scheme),
                        ],
                      ),
                      if (league.description != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          league.description!,
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Follow Button
                Flexible(
                  fit: FlexFit.loose,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: isFollowing
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: sportColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: sportColor, width: 1.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: sportColor, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: sportColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
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

  Widget _buildSportBadge(SportType sport, ColorScheme scheme) {
    final color = _getSportColor(sport);
    final icon = _getSportIcon(sport);
    final name = _getSportName(sport);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderBadge(String gender, ColorScheme scheme) {
    Color badgeColor;
    IconData? icon;

    switch (gender.toLowerCase()) {
      case 'men':
        badgeColor = Colors.blue[600]!;
        icon = Icons.male;
        break;
      case 'women':
        badgeColor = Colors.pink[400]!;
        icon = Icons.female;
        break;
      case 'mixed':
      case 'men & women':
        badgeColor = Colors.purple[400]!;
        icon = null;
        break;
      default:
        badgeColor = scheme.onSurfaceVariant;
        icon = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: badgeColor),
            const SizedBox(width: 4),
          ],
          Text(
            gender,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme scheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: scheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 48,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No leagues found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = '';
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear search'),
            style: TextButton.styleFrom(foregroundColor: primaryGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Skip button
            TextButton(
              onPressed: () {
                // Skip and continue
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            // Continue button
            ElevatedButton(
              onPressed: _followedLeagueIds.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowTeamsPage(
                            selectedLeagueIds: _selectedLeagueIds.toList(),
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                disabledBackgroundColor: scheme.surfaceVariant,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _followedLeagueIds.isEmpty
                        ? 'Select Leagues'
                        : 'Continue (${_followedLeagueIds.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
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

  String _getSportName(SportType sport) {
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
}
