import 'package:flutter/material.dart';
import 'package:sports_news_app/services/api_service.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  int _selectedCategory = 0; // 0: Players, 1: Leagues, 2: Teams, 3: Sports
  final List<String> _categories = ['Players', 'Leagues', 'Teams', 'Sports'];

  // Dynamic data from backend
  List<dynamic> _followedPlayers = [];
  List<dynamic> _followedLeagues = [];
  List<dynamic> _followedTeams = [];
  List<dynamic> _followedSports = [];
  
  // Recommendations data
  List<dynamic> _recommendedSports = [];
  List<dynamic> _recommendedLeagues = [];
  List<dynamic> _recommendedTeams = [];
  List<dynamic> _recommendedPlayers = [];
  
  bool _isLoading = true;
  bool _showRecommendations = false;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    try {
      // Get user data which includes preferences
      final userData = await ApiService.getUser();
      
      setState(() {
        _followedPlayers = userData['preferred_players'] ?? [];
        _followedLeagues = userData['preferred_leagues'] ?? [];
        _followedTeams = userData['preferred_teams'] ?? [];
        _followedSports = userData['preferred_sports'] ?? [];
        _isLoading = false;
      });
      
      // Load recommendations after user preferences are loaded
      _loadRecommendations();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading preferences: $e')),
        );
      }
    }
  }

  Future<void> _loadRecommendations() async {
    try {
      // Get all available data for recommendations
      final allSports = await ApiService.getSports();
      final allLeagues = await ApiService.getAllLeagues();
      final allTeams = await ApiService.getAllTeams();
      final allPlayers = await ApiService.getAllPlayers();
      
      setState(() {
        // Recommend sports user doesn't follow
        _recommendedSports = allSports.where((sport) {
          return !_followedSports.any((followed) => followed['id'] == sport['id']);
        }).take(5).toList(); // Limit to 5 recommendations
        
        // Recommend leagues user doesn't follow
        _recommendedLeagues = allLeagues.where((league) {
          return !_followedLeagues.any((followed) => followed['id'] == league['id']);
        }).take(5).toList();
        
        // Recommend teams user doesn't follow
        _recommendedTeams = allTeams.where((team) {
          return !_followedTeams.any((followed) => followed['id'] == team['id']);
        }).take(5).toList();
        
        // Recommend players user doesn't follow
        _recommendedPlayers = allPlayers.where((player) {
          return !_followedPlayers.any((followed) => followed['id'] == player['id']);
        }).take(5).toList();
      });
    } catch (e) {
      // Handle error silently for recommendations
      print('Error loading recommendations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryTabs(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.favorite,
              color: primaryGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  _getCategorySubtitle(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  String _getCategorySubtitle() {
    switch (_selectedCategory) {
      case 0:
        return '${_followedPlayers.length} Players';
      case 1:
        return '${_followedLeagues.length} Leagues';
      case 2:
        return '${_followedTeams.length} Teams';
      case 3:
        return '${_followedSports.length} Sports';
      default:
        return '0 Items';
    }
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = index;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryGreen : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
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

  Widget _buildContent() {
    List<dynamic> currentItems = _getCurrentCategoryItems();
    List<dynamic> currentRecommendations = _getCurrentRecommendations();

    return Column(
      children: [
        // Toggle between following and recommendations
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showRecommendations = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !_showRecommendations ? primaryGreen : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      'My Following',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_showRecommendations ? Colors.white : primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showRecommendations = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _showRecommendations ? primaryGreen : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Discover',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _showRecommendations ? Colors.white : primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Content
        Expanded(
          child: _showRecommendations 
              ? _buildRecommendationsList(currentRecommendations)
              : _buildFollowingList(currentItems),
        ),
      ],
    );
  }

  Widget _buildFollowingList(List<dynamic> items) {
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItemCard(item, isFollowing: true);
      },
    );
  }

  Widget _buildRecommendationsList(List<dynamic> recommendations) {
    if (recommendations.isEmpty) {
      return _buildNoRecommendationsState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final item = recommendations[index];
        return _buildItemCard(item, isFollowing: false);
      },
    );
  }

  Widget _buildNoRecommendationsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No new recommendations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re following all available items!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<dynamic> _getCurrentRecommendations() {
    switch (_selectedCategory) {
      case 0:
        return _recommendedPlayers;
      case 1:
        return _recommendedLeagues;
      case 2:
        return _recommendedTeams;
      case 3:
        return _recommendedSports;
      default:
        return [];
    }
  }

  List<dynamic> _getCurrentCategoryItems() {
    switch (_selectedCategory) {
      case 0:
        return _followedPlayers;
      case 1:
        return _followedLeagues;
      case 2:
        return _followedTeams;
      case 3:
        return _followedSports;
      default:
        return [];
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getEmptyIcon(),
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _getEmptyTitle(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getEmptySubtitle(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getEmptyIcon() {
    switch (_selectedCategory) {
      case 0:
        return Icons.person_outline;
      case 1:
        return Icons.emoji_events_outlined;
      case 2:
        return Icons.groups_outlined;
      case 3:
        return Icons.sports_outlined;
      default:
        return Icons.favorite_outline;
    }
  }

  String _getEmptyTitle() {
    switch (_selectedCategory) {
      case 0:
        return 'No Players Followed';
      case 1:
        return 'No Leagues Followed';
      case 2:
        return 'No Teams Followed';
      case 3:
        return 'No Sports Followed';
      default:
        return 'Nothing Found';
    }
  }

  String _getEmptySubtitle() {
    switch (_selectedCategory) {
      case 0:
        return 'Start following players to see them here';
      case 1:
        return 'Follow leagues to stay updated with competitions';
      case 2:
        return 'Follow your favorite teams for updates';
      case 3:
        return 'Choose your favorite sports to personalize content';
      default:
        return 'Follow content to see it here';
    }
  }

  Widget _buildItemCard(dynamic item, {required bool isFollowing}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: _buildItemIcon(item),
          ),
        ),
        title: Text(
          item['name'] ?? item['title'] ?? 'Unknown',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: _buildItemSubtitle(item),
        trailing: isFollowing
            ? IconButton(
                onPressed: () => _showUnfollowDialog(item),
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              )
            : IconButton(
                onPressed: () => _followItem(item),
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }

  Widget _buildItemIcon(dynamic item) {
    switch (_selectedCategory) {
      case 0: // Players
        return CircleAvatar(
          backgroundColor: primaryGreen,
          child: Text(
            item['name']?.toString().substring(0, 1).toUpperCase() ?? 'P',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case 1: // Leagues
        return Icon(
          Icons.emoji_events,
          color: primaryGreen,
        );
      case 2: // Teams
        return Icon(
          Icons.groups,
          color: primaryGreen,
        );
      case 3: // Sports
        return Icon(
          Icons.sports,
          color: primaryGreen,
        );
      default:
        return Icon(
          Icons.favorite,
          color: primaryGreen,
        );
    }
  }

  Widget _buildItemSubtitle(dynamic item) {
    switch (_selectedCategory) {
      case 0: // Players
        return Text(item['team_name'] ?? item['position'] ?? 'Player');
      case 1: // Leagues
        return Text(item['sport_name'] ?? 'League');
      case 2: // Teams
        return Text(item['league_name'] ?? item['sport_name'] ?? 'Team');
      case 3: // Sports
        return Text('${item['teams_count'] ?? 0} teams');
      default:
        return const Text('');
    }
  }

  void _showUnfollowDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unfollow'),
        content: Text('Are you sure you want to unfollow ${item['name'] ?? 'this item'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _unfollowItem(item);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Unfollow'),
          ),
        ],
      ),
    );
  }

  Future<void> _followItem(dynamic item) async {
    try {
      switch (_selectedCategory) {
        case 0: // Players
          await ApiService.followPlayer(item['id']);
          break;
        case 1: // Leagues
          await ApiService.followLeague(item['id']);
          break;
        case 2: // Teams
          await ApiService.followTeam(item['id']);
          break;
        case 3: // Sports
          await ApiService.followSport(item['id']);
          break;
      }
      
      // Refresh data
      await _loadUserPreferences();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Following ${item['name'] ?? 'item'}'),
          backgroundColor: primaryGreen,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error following item: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _unfollowItem(dynamic item) async {
    try {
      switch (_selectedCategory) {
        case 0: // Players
          await ApiService.unfollowPlayer(item['id']);
          break;
        case 1: // Leagues
          await ApiService.unfollowLeague(item['id']);
          break;
        case 2: // Teams
          await ApiService.unfollowTeam(item['id']);
          break;
        case 3: // Sports
          await ApiService.unfollowSport(item['id']);
          break;
      }
      
      // Refresh data
      await _loadUserPreferences();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unfollowed ${item['name'] ?? 'item'}'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error unfollowing item: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
