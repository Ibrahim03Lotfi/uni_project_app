import 'package:flutter/material.dart';
import 'package:sports_news_app/services/api_service.dart';
import 'package:sports_news_app/widget_tree.dart';

class PreferencesSummaryPage extends StatefulWidget {
  const PreferencesSummaryPage({super.key});

  @override
  State<PreferencesSummaryPage> createState() => _PreferencesSummaryPageState();
}

class _PreferencesSummaryPageState extends State<PreferencesSummaryPage>
    with TickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  Map<String, dynamic> _userPreferences = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadUserPreferences();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  Future<void> _loadUserPreferences() async {
    try {
      // First, get current user info to debug authentication
      final userInfo = await ApiService.getUser();
      print('=== DEBUG: Current User Info ===');
      print('User ID: ${userInfo['id']}');
      print('User Name: ${userInfo['name']}');
      print('User Email: ${userInfo['email']}');
      print('User Role: ${userInfo['role']}');
      
      final preferences = await ApiService.getUserPreferences();
      print('=== DEBUG: Raw preferences data ===');
      print('Sports: ${preferences['sports']}');
      print('Teams: ${preferences['teams']}');
      print('Leagues: ${preferences['leagues']}');
      print('Players: ${preferences['players']}');
      print('=== END DEBUG ===');
      
      setState(() {
        _userPreferences = preferences;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading preferences: $e'); // Debug print
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load preferences: $e';
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? _buildErrorView()
                : FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 32),
                          _buildSportsSection(),
                          const SizedBox(height: 32),
                          _buildLeaguesSection(),
                          const SizedBox(height: 32),
                          _buildTeamsSection(),
                          const SizedBox(height: 32),
                          _buildPlayersSection(),
                          const SizedBox(height: 40),
                          _buildContinueButton(),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Preferences',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'An unknown error occurred',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadUserPreferences,
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryGreen, darkGreen],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferences Saved!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Here\'s what you\'ve selected',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSportsSection() {
    final sports = _userPreferences['sports'] as List<dynamic>? ?? [];
    print('DEBUG: Building sports section with $sports items');
    
    return _buildSection(
      'Sports',
      Icons.sports,
      sports.isEmpty ? 'No sports selected' : null,
      sports.isEmpty
          ? null
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: sports.map((sport) => _buildSportChip(sport)).toList(),
            ),
    );
  }

  Widget _buildLeaguesSection() {
    final leagues = _userPreferences['leagues'] as List<dynamic>? ?? [];
    print('DEBUG: Building leagues section with $leagues items');
    
    return _buildSection(
      'Leagues',
      Icons.emoji_events,
      leagues.isEmpty ? 'No leagues selected' : null,
      leagues.isEmpty
          ? null
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: leagues.map((league) => _buildLeagueChip(league)).toList(),
            ),
    );
  }

  Widget _buildTeamsSection() {
    final teams = _userPreferences['teams'] as List<dynamic>? ?? [];
    print('DEBUG: Building teams section with $teams items');
    
    return _buildSection(
      'Teams',
      Icons.groups,
      teams.isEmpty ? 'No teams selected' : null,
      teams.isEmpty
          ? null
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teams.map((team) => _buildTeamChip(team)).toList(),
            ),
    );
  }

  Widget _buildPlayersSection() {
    final players = _userPreferences['players'] as List<dynamic>? ?? [];
    print('DEBUG: Building players section with $players items');
    
    return _buildSection(
      'Players',
      Icons.person,
      players.isEmpty ? 'No players selected' : null,
      players.isEmpty
          ? null
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: players.map((player) => _buildPlayerChip(player)).toList(),
            ),
    );
  }

  Widget _buildSection(String title, IconData icon, String? emptyMessage, Widget? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: primaryGreen, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (emptyMessage != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              emptyMessage,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          )
        else if (content != null)
          content,
      ],
    );
  }

  Widget _buildSportChip(dynamic sport) {
    print('DEBUG: Building sport chip for: $sport');
    return Chip(
      label: Text(sport['name'] ?? 'Unknown'),
      avatar: sport['emoji'] != null && sport['emoji'].isNotEmpty ? Text(sport['emoji']) : null,
      backgroundColor: primaryGreen.withOpacity(0.1),
      labelStyle: TextStyle(color: primaryGreen),
    );
  }

  Widget _buildLeagueChip(dynamic league) {
    print('DEBUG: Building league chip for: $league');
    return Chip(
      label: Text(league['name'] ?? 'Unknown'),
      avatar: league['logo_emoji'] != null && league['logo_emoji'].isNotEmpty ? Text(league['logo_emoji']) : null,
      backgroundColor: Colors.blue.withOpacity(0.1),
      labelStyle: TextStyle(color: Colors.blue),
    );
  }

  Widget _buildTeamChip(dynamic team) {
    print('DEBUG: Building team chip for: $team');
    return Chip(
      label: Text(team['name'] ?? 'Unknown'),
      avatar: team['logo_emoji'] != null && team['logo_emoji'].isNotEmpty ? Text(team['logo_emoji']) : null,
      backgroundColor: Colors.orange.withOpacity(0.1),
      labelStyle: TextStyle(color: Colors.orange),
    );
  }

  Widget _buildPlayerChip(dynamic player) {
    print('DEBUG: Building player chip for: $player');
    return Chip(
      label: Text(player['name'] ?? 'Unknown'),
      avatar: const Icon(Icons.person, size: 16),
      backgroundColor: Colors.purple.withOpacity(0.1),
      labelStyle: TextStyle(color: Colors.purple),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WidgetTree()),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Continue to App',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
