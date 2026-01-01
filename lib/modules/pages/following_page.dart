import 'package:flutter/material.dart';

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

  // Sample data for each category
  final List<Map<String, dynamic>> _allPlayers = [
    {
      'id': '1',
      'name': 'Cristiano Ronaldo',
      'logo': '🇵🇹',
      'league': 'Al-Nassr',
      'isFollowing': true,
    },
    {
      'id': '2',
      'name': 'Lionel Messi',
      'logo': '🇦🇷',
      'league': 'Inter Miami',
      'isFollowing': true,
    },
    {
      'id': '3',
      'name': 'Kylian Mbappé',
      'logo': '🇫🇷',
      'league': 'Paris Saint-Germain',
      'isFollowing': false,
    },
    {
      'id': '4',
      'name': 'Erling Haaland',
      'logo': '🇳🇴',
      'league': 'Manchester City',
      'isFollowing': false,
    },
    {
      'id': '5',
      'name': 'Mohamed Salah',
      'logo': '🇪🇬',
      'league': 'Liverpool',
      'isFollowing': false,
    },
    {
      'id': '6',
      'name': 'Kevin De Bruyne',
      'logo': '🇧🇪',
      'league': 'Manchester City',
      'isFollowing': true,
    },
    {
      'id': '7',
      'name': 'Karim Benzema',
      'logo': '🇫🇷',
      'league': 'Al-Ittihad',
      'isFollowing': false,
    },
    {
      'id': '8',
      'name': 'Neymar Jr',
      'logo': '🇧🇷',
      'league': 'Al-Hilal',
      'isFollowing': false,
    },
  ];

  final List<Map<String, dynamic>> _allLeagues = [
    {
      'id': '1',
      'name': 'Premier League',
      'logo': '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
      'sport': 'Football',
      'isFollowing': true,
    },
    {
      'id': '2',
      'name': 'La Liga',
      'logo': '🇪🇸',
      'sport': 'Football',
      'isFollowing': false,
    },
    {
      'id': '3',
      'name': 'NBA',
      'logo': '🏀',
      'sport': 'Basketball',
      'isFollowing': true,
    },
    {
      'id': '4',
      'name': 'UEFA Champions League',
      'logo': '⭐',
      'sport': 'Football',
      'isFollowing': true,
    },
    {
      'id': '5',
      'name': 'Serie A',
      'logo': '🇮🇹',
      'sport': 'Football',
      'isFollowing': false,
    },
    {
      'id': '6',
      'name': 'Bundesliga',
      'logo': '🇩🇪',
      'sport': 'Football',
      'isFollowing': false,
    },
    {
      'id': '7',
      'name': 'MLB',
      'logo': '⚾',
      'sport': 'Baseball',
      'isFollowing': false,
    },
    {
      'id': '8',
      'name': 'NFL',
      'logo': '🏈',
      'sport': 'American Football',
      'isFollowing': true,
    },
  ];

  final List<Map<String, dynamic>> _allTeams = [
    {
      'id': '1',
      'name': 'Manchester United',
      'logo': '🔴',
      'league': 'Premier League',
      'isFollowing': true,
    },
    {
      'id': '2',
      'name': 'Real Madrid',
      'logo': '⚪',
      'league': 'La Liga',
      'isFollowing': true,
    },
    {
      'id': '3',
      'name': 'Los Angeles Lakers',
      'logo': '💜💛',
      'league': 'NBA',
      'isFollowing': false,
    },
    {
      'id': '4',
      'name': 'FC Barcelona',
      'logo': '🔵🔴',
      'league': 'La Liga',
      'isFollowing': true,
    },
    {
      'id': '5',
      'name': 'Liverpool',
      'logo': '🔴',
      'league': 'Premier League',
      'isFollowing': false,
    },
    {
      'id': '6',
      'name': 'Golden State Warriors',
      'logo': '💙💛',
      'league': 'NBA',
      'isFollowing': false,
    },
    {
      'id': '7',
      'name': 'Bayern Munich',
      'logo': '🔴',
      'league': 'Bundesliga',
      'isFollowing': true,
    },
    {
      'id': '8',
      'name': 'PSG',
      'logo': '🔵🔴',
      'league': 'Ligue 1',
      'isFollowing': false,
    },
  ];

  final List<Map<String, dynamic>> _allSports = [
    {'id': '1', 'name': 'Football', 'logo': '⚽', 'isFollowing': true},
    {'id': '2', 'name': 'Basketball', 'logo': '🏀', 'isFollowing': true},
    {'id': '3', 'name': 'Tennis', 'logo': '🎾', 'isFollowing': false},
    {'id': '4', 'name': 'Baseball', 'logo': '⚾', 'isFollowing': false},
    {
      'id': '5',
      'name': 'American Football',
      'logo': '🏈',
      'isFollowing': false,
    },
    {'id': '6', 'name': 'Volleyball', 'logo': '🏐', 'isFollowing': false},
    {'id': '7', 'name': 'Cricket', 'logo': '🏏', 'isFollowing': false},
    {'id': '8', 'name': 'Rugby', 'logo': '🏉', 'isFollowing': true},
  ];

  List<Map<String, dynamic>> get _currentCategoryData {
    switch (_selectedCategory) {
      case 0:
        return _allPlayers;
      case 1:
        return _allLeagues;
      case 2:
        return _allTeams;
      case 3:
        return _allSports;
      default:
        return _allPlayers;
    }
  }

  void _toggleFollow(String id) {
    setState(() {
      final data = _currentCategoryData;
      final itemIndex = data.indexWhere((item) => item['id'] == id);
      if (itemIndex != -1) {
        data[itemIndex]['isFollowing'] = !data[itemIndex]['isFollowing'];
      }
    });
  }

  String _getCategoryTitle() {
    return _categories[_selectedCategory];
  }

  String _getCategorySubtitle() {
    final data = _currentCategoryData;
    final followingCount = data.where((item) => item['isFollowing']).length;
    final totalCount = data.length;
    return '$followingCount/$totalCount ${_categories[_selectedCategory].toLowerCase()} followed';
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
            // Category Tabs
            _buildCategoryTabs(),
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
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Following',
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
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getCategorySubtitle().split('/')[0],
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outlineVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
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
    final data = _currentCategoryData;
    final followingItems = data.where((item) => item['isFollowing']).toList();
    final notFollowingItems = data
        .where((item) => !item['isFollowing'])
        .toList();

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
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
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
                        _getCategoryTitle(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getCategorySubtitle(),
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Following Section
                if (followingItems.isNotEmpty) ...[
                  _buildSectionHeader('Following'),
                  ...followingItems.map(
                    (item) => _buildListItem(item, isFollowing: true),
                  ),
                  const SizedBox(height: 20),
                ],
                // Suggestions Section
                if (notFollowingItems.isNotEmpty) ...[
                  _buildSectionHeader('Suggestions'),
                  ...notFollowingItems.map(
                    (item) => _buildListItem(item, isFollowing: false),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildListItem(
    Map<String, dynamic> item, {
    required bool isFollowing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFollowing
              ? primaryGreen.withOpacity(0.3)
              : Theme.of(context).colorScheme.outlineVariant,
          width: isFollowing ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Logo/Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isFollowing
                        ? primaryGreen.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      item['logo'],
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getItemSubtitle(item),
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Follow/Unfollow Button
                _buildFollowButton(item['id'], isFollowing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFollowButton(String id, bool isFollowing) {
    return Container(
      width: 100,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFollowing
              ? Theme.of(context).colorScheme.outlineVariant
              : primaryGreen,
          width: 1.5,
        ),
        color: isFollowing ? Colors.transparent : primaryGreen,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleFollow(id),
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isFollowing ? Icons.check : Icons.add,
                  size: 16,
                  color: isFollowing
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isFollowing
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getItemSubtitle(Map<String, dynamic> item) {
    switch (_selectedCategory) {
      case 0: // Players
        return item['league'];
      case 1: // Leagues
        return item['sport'];
      case 2: // Teams
        return item['league'];
      case 3: // Sports
        return '';
      default:
        return '';
    }
  }

  IconData _getCategoryIcon() {
    switch (_selectedCategory) {
      case 0: // Players
        return Icons.people_outline;
      case 1: // Leagues
        return Icons.emoji_events_outlined;
      case 2: // Teams
        return Icons.groups_outlined;
      case 3: // Sports
        return Icons.sports_soccer_outlined;
      default:
        return Icons.people_outline;
    }
  }
}
