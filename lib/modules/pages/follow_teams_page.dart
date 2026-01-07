import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sports_news_app/services/api_service.dart';
import 'package:sports_news_app/modules/pages/follow_players_page.dart';
import 'package:sports_news_app/modules/pages/follow_leagues_page.dart';

// Keep your existing enums and Team model
enum SportType { football, basketball, tennis, volleyball }
enum TeamType { club, national }

class Team {
  final String id;
  final String name;
  final String country;
  final String logoEmoji;
  final TeamType type;
  final SportType sport;
  final String? league;
  final String? conference;
  bool isFollowing;

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.logoEmoji,
    required this.type,
    required this.sport,
    this.league,
    this.conference,
    this.isFollowing = false,
  });
}

class FollowTeamsPage extends StatefulWidget {
  final List<int> selectedLeagueIds;
  const FollowTeamsPage({super.key, required this.selectedLeagueIds});

  @override
  State<FollowTeamsPage> createState() => _FollowTeamsPageState();
}

class _FollowTeamsPageState extends State<FollowTeamsPage>
    with SingleTickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<dynamic> _teams = [];
  Set<int> _selectedTeamIds = {};
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchTeams();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchTeams() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      List<dynamic> allTeams = [];
      
      // For each selected league, get its teams
      for (int leagueId in widget.selectedLeagueIds) {
        try {
          final teamsResponse = await http.get(
            Uri.parse('${ApiService.baseUrl}/leagues/$leagueId/teams'),
            headers: await ApiService.headers,
          );

          if (teamsResponse.statusCode == 200) {
            final teamsData = json.decode(teamsResponse.body);
            final teams = teamsData['data'] ?? [];
            allTeams.addAll(teams);
          }
        } catch (e) {
          print('Error fetching teams for league $leagueId: $e');
        }
      }

      // If no teams from API, use fallback hardcoded teams
      if (allTeams.isEmpty) {
        allTeams = _getFallbackTeams();
      }

      setState(() {
        _teams = allTeams;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load teams. Please try again.';
        _isLoading = false;
      });
    }
  }

  List<dynamic> _getFallbackTeams() {
    return [
      // Football Teams
      {'id': 1, 'name': 'Arsenal', 'sport': 'football', 'league': 'Premier League', 'logo_emoji': '⚽'},
      {'id': 2, 'name': 'Manchester United', 'sport': 'football', 'league': 'Premier League', 'logo_emoji': '⚽'},
      {'id': 3, 'name': 'Liverpool', 'sport': 'football', 'league': 'Premier League', 'logo_emoji': '⚽'},
      {'id': 4, 'name': 'Chelsea', 'sport': 'football', 'league': 'Premier League', 'logo_emoji': '⚽'},
      {'id': 5, 'name': 'Real Madrid', 'sport': 'football', 'league': 'La Liga', 'logo_emoji': '⚽'},
      {'id': 6, 'name': 'Barcelona', 'sport': 'football', 'league': 'La Liga', 'logo_emoji': '⚽'},
      // Basketball Teams
      {'id': 7, 'name': 'Los Angeles Lakers', 'sport': 'basketball', 'league': 'NBA', 'logo_emoji': '🏀'},
      {'id': 8, 'name': 'Boston Celtics', 'sport': 'basketball', 'league': 'NBA', 'logo_emoji': '🏀'},
      {'id': 9, 'name': 'Golden State Warriors', 'sport': 'basketball', 'league': 'NBA', 'logo_emoji': '🏀'},
      {'id': 10, 'name': 'Miami Heat', 'sport': 'basketball', 'league': 'NBA', 'logo_emoji': '🏀'},
      // Tennis Players
      {'id': 11, 'name': 'Novak Djokovic', 'sport': 'tennis', 'league': 'ATP Tour', 'logo_emoji': '🎾'},
      {'id': 12, 'name': 'Rafael Nadal', 'sport': 'tennis', 'league': 'ATP Tour', 'logo_emoji': '🎾'},
      {'id': 13, 'name': 'Roger Federer', 'sport': 'tennis', 'league': 'ATP Tour', 'logo_emoji': '🎾'},
      {'id': 14, 'name': 'Carlos Alcaraz', 'sport': 'tennis', 'league': 'ATP Tour', 'logo_emoji': '🎾'},
      // Volleyball Teams
      {'id': 15, 'name': 'Brazil National Team', 'sport': 'volleyball', 'league': 'FIVB World Tour', 'logo_emoji': '🏐'},
      {'id': 16, 'name': 'Italy National Team', 'sport': 'volleyball', 'league': 'FIVB World Tour', 'logo_emoji': '🏐'},
      {'id': 17, 'name': 'USA National Team', 'sport': 'volleyball', 'league': 'FIVB World Tour', 'logo_emoji': '🏐'},
      {'id': 18, 'name': 'Russia National Team', 'sport': 'volleyball', 'league': 'FIVB World Tour', 'logo_emoji': '🏐'},
    ];
  }

  void _onTeamSelected(int teamId, bool selected) {
    setState(() {
      if (selected) {
        _selectedTeamIds.add(teamId);
      } else {
        _selectedTeamIds.remove(teamId);
      }
    });
  }

  Future<void> _onFinish() async {
    if (_selectedTeamIds.isEmpty) return;

    try {
      print('Saving teams: ${_selectedTeamIds.toList()}');
      await ApiService.saveTeamsPreferences(_selectedTeamIds.toList());
      print('Teams preferences saved successfully');
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FollowPlayersPage(selectedTeamIds: _selectedTeamIds.toList())),
        );
      }
    } catch (e) {
      print('Error saving teams: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save teams preferences')),
      );
    }
  }

  Widget _buildTeamCard(dynamic team) {
    final teamId = int.tryParse(team['id'].toString()) ?? 0;
    final isSelected = _selectedTeamIds.contains(teamId);
    final sportType = _getSportType(team['sport']);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? primaryGreen : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: () => _onTeamSelected(teamId, !isSelected),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Team Logo/Emoji
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _getSportColor(sportType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    team['logo_emoji'] ?? '🏆',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Team Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team['name'] ?? 'Unknown Team',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (team['league'] != null)
                      Text(
                        team['league']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              // Checkbox
              Checkbox(
                value: isSelected,
                onChanged: (bool? selected) {
                  if (selected != null) {
                    _onTeamSelected(teamId, selected);
                  }
                },
                activeColor: primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllTeamsTab() {
    final filteredTeams = _teams.where((team) {
      if (_searchQuery.isNotEmpty) {
        final name = team['name']?.toString().toLowerCase() ?? '';
        final league = team['league']?.toString().toLowerCase() ?? '';
        return name.contains(_searchQuery) || league.contains(_searchQuery);
      }
      return true; // Show all teams in "All" tab
    }).toList();

    if (filteredTeams.isEmpty) {
      return Center(
        child: Text(
          'No teams found',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredTeams.length,
      itemBuilder: (context, index) {
        return _buildTeamCard(filteredTeams[index]);
      },
    );
  }

  Widget _buildSportTab(SportType sportType) {
    final filteredTeams = _teams.where((team) {
      if (_searchQuery.isNotEmpty) {
        final name = team['name']?.toString().toLowerCase() ?? '';
        final league = team['league']?.toString().toLowerCase() ?? '';
        return name.contains(_searchQuery) || league.contains(_searchQuery);
      }
      
      // Get sport name from team data
      final teamSport = (team['sport']?.toString().toLowerCase() ?? '');
      
      // Map sport type to expected sport name
      switch (sportType) {
        case SportType.football:
          return teamSport.contains('football') || teamSport.contains('soccer');
        case SportType.basketball:
          return teamSport.contains('basketball');
        case SportType.tennis:
          return teamSport.contains('tennis');
        case SportType.volleyball:
          return teamSport.contains('volleyball');
        default:
          return false;
      }
    }).toList();

    if (filteredTeams.isEmpty) {
      return Center(
        child: Text(
          'No teams found',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredTeams.length,
      itemBuilder: (context, index) {
        return _buildTeamCard(filteredTeams[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Teams'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: primaryGreen,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: primaryGreen,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Football'),
            Tab(text: 'Basketball'),
            Tab(text: 'Tennis'),
            Tab(text: 'Volleyball'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search teams...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Team Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: _selectedTeamIds.isNotEmpty
                      ? primaryGreen
                      : Colors.grey[400],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_selectedTeamIds.length} Selected',
                  style: TextStyle(
                    color: _selectedTeamIds.isNotEmpty
                        ? primaryGreen
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Team List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _errorMessage,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _fetchTeams,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          // All Teams Tab
                          _buildAllTeamsTab(),
                          // Sport-specific tabs
                          _buildSportTab(SportType.football),
                          _buildSportTab(SportType.basketball),
                          _buildSportTab(SportType.tennis),
                          _buildSportTab(SportType.volleyball),
                        ],
                      ),
          ),
          // Continue Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Skip Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowLeaguesPage(selectedSportIds: []),
                      ),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                // Continue Button
                ElevatedButton(
                  onPressed:
                      _selectedTeamIds.isNotEmpty ? _onFinish : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SportType _getSportType(String? sportName) {
    switch (sportName?.toLowerCase()) {
      case 'basketball':
        return SportType.basketball;
      case 'tennis':
        return SportType.tennis;
      case 'volleyball':
        return SportType.volleyball;
      case 'football':
      default:
        return SportType.football;
    }
  }

  Color _getSportColor(SportType sportType) {
    switch (sportType) {
      case SportType.football:
        return Colors.blue;
      case SportType.basketball:
        return Colors.orange;
      case SportType.tennis:
        return Colors.green;
      case SportType.volleyball:
        return Colors.purple;
    }
  }
}