import 'package:flutter/material.dart';
import 'package:sports_news_app/modules/pages/follow_teams_page.dart';
import 'package:sports_news_app/services/api_service.dart';

// Sport Model
class Sport {
  final int id;
  final String name;
  final IconData? icon; // Changed from String? to IconData?
  final Color color; // Changed from String to Color
  final String description;
  final String emoji;
  bool isSelected;

  Sport({
    required this.id,
    required this.name,
    this.icon,
    required this.color,
    required this.description,
    required this.emoji,
    this.isSelected = false,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    // Parse color from hex string
    Color parseColor(String hexColor) {
      hexColor = hexColor.replaceAll('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    // Map icon string to IconData
    IconData? parseIcon(String? iconName) {
      if (iconName == null) return null;
      // You'll need to create a mapping from your API's icon names to Flutter's IconData
      // This is a simplified example
      Map<String, IconData> iconMap = {
        'sports_soccer': Icons.sports_soccer,
        'sports_basketball': Icons.sports_basketball,
        'sports_tennis': Icons.sports_tennis,
        'sports_volleyball': Icons.sports_volleyball,
      };
      return iconMap[iconName];
    }

    return Sport(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      name: json['name'] ?? '',
      icon: parseIcon(json['icon']),
      color: parseColor(json['color'] ?? '#000000'),
      description: json['description'] ?? '',
      emoji: json['emoji'] ?? '',
      isSelected: false,
    );
  }
}

class ChooseSportsPage extends StatefulWidget {
  const ChooseSportsPage({super.key});

  @override
  State<ChooseSportsPage> createState() => _ChooseSportsPageState();
}

class _ChooseSportsPageState extends State<ChooseSportsPage>
    with TickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;

  List<Sport> _sports = [];
  Set<int> _selectedSportIds = {}; // Changed from Set<String> to Set<int>

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initializeSports();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeController.forward();
  }

  void _initializeSports() async {
    try {
      final sportsData = await ApiService.getSports();
      setState(() {
        _sports = sportsData.map((data) => Sport.fromJson(data)).toList();

        // Load user's already selected sports
        _loadUserPreferences();
      });
    } catch (e) {
      print('Error loading sports: $e');
      // Fallback to hardcoded sports
      _loadHardcodedSports();
    }
  }

  void _loadHardcodedSports() {
    _sports = [
      Sport(
        id: 1,
        name: 'Football',
        icon: Icons.sports_soccer,
        color: primaryGreen,
        emoji: '⚽',
        description: 'The beautiful game loved by billions worldwide',
      ),
      Sport(
        id: 2,
        name: 'Basketball',
        icon: Icons.sports_basketball,
        color: Colors.orange.shade700,
        emoji: '🏀',
        description: 'Fast-paced action on the hardwood court',
      ),
      Sport(
        id: 3,
        name: 'Tennis',
        icon: Icons.sports_tennis,
        color: Colors.yellow.shade800,
        emoji: '🎾',
        description: 'Elite individual competition on various surfaces',
      ),
      Sport(
        id: 4,
        name: 'Volleyball',
        icon: Icons.sports_volleyball,
        color: Colors.blue.shade700,
        emoji: '🏐',
        description: 'Exciting team sport with powerful spikes and digs',
      ),
    ];
  }

  void _loadUserPreferences() async {
    try {
      final userSports = await ApiService.getUserSports();
      final userSportIds = userSports
          .map((s) => s['id'] is String ? int.parse(s['id']) : s['id'] as int)
          .toList();

      setState(() {
        for (var sport in _sports) {
          sport.isSelected = userSportIds.contains(sport.id);
          if (sport.isSelected) {
            _selectedSportIds.add(sport.id);
          }
        }
      });
    } catch (e) {
      print('Error loading user preferences: $e');
    }
  }

  void _toggleSport(Sport sport) async {
    setState(() {
      if (_selectedSportIds.contains(sport.id)) {
        _selectedSportIds.remove(sport.id);
        sport.isSelected = false;
      } else {
        _selectedSportIds.add(sport.id);
        sport.isSelected = true;
      }
    });

    // Save to backend
    try {
      await ApiService.saveSportsPreferences(_selectedSportIds.toList());
    } catch (e) {
      print('Error saving preferences: $e');
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save preferences: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _selectAll() {
    setState(() {
      for (var sport in _sports) {
        _selectedSportIds.add(sport.id);
        sport.isSelected = true;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _selectedSportIds.clear();
      for (var sport in _sports) {
        sport.isSelected = false;
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
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
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: _buildMainContent(scheme, isDesktop: true),
                  ),
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
      width: 300,
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
                _buildProgressItem(
                  'Choose Sports',
                  false,
                  1,
                  isActive: true,
                  scheme: scheme,
                ),
                _buildProgressItem('Select Leagues', false, 2, scheme: scheme),
                _buildProgressItem('Follow Teams', false, 3, scheme: scheme),
                _buildProgressItem('Follow Players', false, 4, scheme: scheme),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          // Welcome Message
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome! 👋',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Let\'s personalize your sports news experience. Start by selecting the sports you\'re interested in.',
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Selected Sports Summary
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
                _buildSelectedSportsIcons(),
                const SizedBox(height: 12),
                Text(
                  '${_selectedSportIds.length}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
                Text(
                  _selectedSportIds.length == 1
                      ? 'Sport Selected'
                      : 'Sports Selected',
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

  Widget _buildSelectedSportsIcons() {
    if (_selectedSportIds.isEmpty) {
      return Icon(Icons.sports, color: Colors.grey[400], size: 40);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _sports
          .where((s) => _selectedSportIds.contains(s.id))
          .take(4)
          .map((sport) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: sport.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(sport.icon, color: sport.color, size: 20),
            );
          })
          .toList(),
    );
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
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Sports',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Select the sports you want to follow',
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Quick Actions
          Row(
            children: [
              TextButton.icon(
                onPressed: _selectedSportIds.length == _sports.length
                    ? _clearAll
                    : _selectAll,
                icon: Icon(
                  _selectedSportIds.length == _sports.length
                      ? Icons.deselect
                      : Icons.select_all,
                  size: 20,
                ),
                label: Text(
                  _selectedSportIds.length == _sports.length
                      ? 'Clear All'
                      : 'Select All',
                ),
                style: TextButton.styleFrom(foregroundColor: primaryGreen),
              ),
              const SizedBox(width: 16),
              _buildSelectedChip(scheme),
              const SizedBox(width: 16),
              _buildContinueButton(),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== TABLET LAYOUT ====================
  Widget _buildTabletLayout(ColorScheme scheme) {
    return Column(
      children: [
        _buildMobileHeader(scheme),
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSportsGrid(
                scheme,
                crossAxisCount: 2,
                isTablet: true,
              ),
            ),
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
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildSportsGrid(scheme, crossAxisCount: 1, isTablet: false),
          ),
        ),
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
              // Logo
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Sports',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              _buildSelectedChip(scheme),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            'Select at least one sport to personalize your news feed',
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          // Quick Select All Button
          Row(
            children: [
              TextButton.icon(
                onPressed: _selectedSportIds.length == _sports.length
                    ? _clearAll
                    : _selectAll,
                icon: Icon(
                  _selectedSportIds.length == _sports.length
                      ? Icons.deselect
                      : Icons.select_all,
                  size: 18,
                ),
                label: Text(
                  _selectedSportIds.length == _sports.length
                      ? 'Clear All'
                      : 'Select All Sports',
                  style: const TextStyle(fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: primaryGreen,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedChip(ColorScheme scheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _selectedSportIds.isNotEmpty
            ? primaryGreen.withOpacity(0.1)
            : scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _selectedSportIds.isNotEmpty
              ? primaryGreen.withOpacity(0.3)
              : scheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _selectedSportIds.isNotEmpty
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: _selectedSportIds.isNotEmpty
                ? primaryGreen
                : scheme.onSurfaceVariant,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            '${_selectedSportIds.length} Selected',
            style: TextStyle(
              color: _selectedSportIds.isNotEmpty
                  ? primaryGreen
                  : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: _selectedSportIds.isNotEmpty
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FollowTeamsPage(),
                ),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey[300],
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
                  child: const Icon(
                    Icons.sports,
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
                        'What sports do you love?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Select all that interest you - you can change this later',
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
          Divider(height: 1, color: scheme.outlineVariant),
          // Sports Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _buildDesktopSportsGrid(scheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSportsGrid(ColorScheme scheme) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.8,
      ),
      itemCount: _sports.length,
      itemBuilder: (context, index) {
        return _buildSportCardDesktop(_sports[index], scheme);
      },
    );
  }

  Widget _buildSportsGrid(
    ColorScheme scheme, {
    required int crossAxisCount,
    required bool isTablet,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sports.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildSportCardMobile(
            _sports[index],
            scheme,
            isTablet: isTablet,
          ),
        );
      },
    );
  }

  Widget _buildSportCardDesktop(Sport sport, ColorScheme scheme) {
    final isSelected = _selectedSportIds.contains(sport.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? sport.color.withOpacity(0.05) : scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? sport.color : scheme.outlineVariant,
          width: isSelected ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? sport.color.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: isSelected ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleSport(sport),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                // Sport Icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? sport.color.withOpacity(0.15)
                        : scheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        sport.icon ?? Icons.sports, // Added null check
                        color: isSelected
                            ? sport.color
                            : scheme.onSurfaceVariant,
                        size: 40,
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Text(
                          sport.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Sport Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sport.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? sport.color
                                    : scheme.onSurface,
                              ),
                            ),
                          ),
                          // Checkbox
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? sport.color
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? sport.color
                                    : scheme.outline,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sport.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Popular Leagues - using hardcoded examples since not in model
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: _getPopularLeaguesForSport(sport).map((
                          league,
                        ) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? sport.color.withOpacity(0.1)
                                  : scheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              league,
                              style: TextStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? sport.color
                                    : scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to get popular leagues for each sport
  List<String> _getPopularLeaguesForSport(Sport sport) {
    switch (sport.name.toLowerCase()) {
      case 'football':
        return ['Premier League', 'La Liga', 'Champions League'];
      case 'basketball':
        return ['NBA', 'EuroLeague', 'WNBA'];
      case 'tennis':
        return ['Wimbledon', 'US Open', 'Australian Open'];
      case 'volleyball':
        return ['FIVB', 'AVP', 'NCAA'];
      default:
        return ['Major League', 'Professional', 'International'];
    }
  }

  Widget _buildSportCardMobile(
    Sport sport,
    ColorScheme scheme, {
    required bool isTablet,
  }) {
    final isSelected = _selectedSportIds.contains(sport.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? sport.color.withOpacity(0.05) : scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? sport.color : scheme.outlineVariant,
          width: isSelected ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? sport.color.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: isSelected ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleSport(sport),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    // Sport Icon
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? sport.color.withOpacity(0.15)
                            : scheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            sport.icon ?? Icons.sports, // Added null check
                            color: isSelected
                                ? sport.color
                                : scheme.onSurfaceVariant,
                            size: 36,
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Text(
                              sport.emoji,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Sport Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sport.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? sport.color
                                  : scheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sport.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: scheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Checkbox
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected ? sport.color : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? sport.color : scheme.outline,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Popular Leagues
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? sport.color.withOpacity(0.05)
                        : scheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Leagues',
                        style: TextStyle(
                          fontSize: 11,
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _getPopularLeaguesForSport(sport).map((
                          league,
                        ) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? sport.color.withOpacity(0.15)
                                  : scheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? sport.color.withOpacity(0.3)
                                    : scheme.outlineVariant,
                              ),
                            ),
                            child: Text(
                              league,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? sport.color
                                    : scheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selected sports preview
            if (_selectedSportIds.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryGreen.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Row(
                      children: _sports
                          .where((s) => _selectedSportIds.contains(s.id))
                          .map((sport) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                sport.icon ?? Icons.sports,
                                color: sport.color,
                                size: 20,
                              ),
                            );
                          })
                          .toList(),
                    ),
                    Expanded(
                      child: Text(
                        _selectedSportIds.length == 1
                            ? '${_sports.firstWhere((s) => _selectedSportIds.contains(s.id)).name} selected'
                            : '${_selectedSportIds.length} sports selected',
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                // Skip button
                TextButton(
                  onPressed: () {
                    // Skip and continue with default
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
                  onPressed: _selectedSportIds.isNotEmpty
                      ? () async {
                          try {
                            // Save final selection
                            await ApiService.saveSportsPreferences(
                              _selectedSportIds.toList(),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FollowTeamsPage(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
                        _selectedSportIds.isEmpty
                            ? 'Select Sports'
                            : 'Continue',
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
          ],
        ),
      ),
    );
  }
}
