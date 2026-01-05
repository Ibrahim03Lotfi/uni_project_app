import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sports_news_app/services/api_service.dart';
import 'package:sports_news_app/modules/pages/follow_Leagues _page.dart';

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
  final List<int> selectedSportIds;
  const FollowTeamsPage({super.key, required this.selectedSportIds});

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
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/teams'),
        headers: await ApiService.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _teams = data['data'] ?? [];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load teams. Please try again.';
        _isLoading = false;
      });
    }
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

  Future<void> _onContinue() async {
    if (_selectedTeamIds.isEmpty) return;

    try {
      await ApiService.savePreferences({
        'team_ids': _selectedTeamIds.toList(),
      });
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FollowLeaguesPage(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save team preferences'),
            backgroundColor: Colors.red,
          ),
        );
      }
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

  Widget _buildSportTab(SportType sportType) {
    final filteredTeams = _teams.where((team) {
      if (_searchQuery.isNotEmpty) {
        final name = team['name']?.toString().toLowerCase() ?? '';
        final league = team['league']?.toString().toLowerCase() ?? '';
        return name.contains(_searchQuery) || league.contains(_searchQuery);
      }
      return team['sport']?.toLowerCase() == sportType.toString().split('.').last;
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
                          // All Teams
                          
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
                        builder: (context) => const FollowLeaguesPage(),
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
                      _selectedTeamIds.isNotEmpty ? _onContinue : null,
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