import 'package:flutter/material.dart';
import 'package:sports_news_app/modules/pages/login_page.dart';
import 'package:sports_news_app/modules/pages/register_page.dart';
import 'package:sports_news_app/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color adminColor = Color(0xFF9C27B0);

  // Admin state variables
  String? _userRole;
  String? _adminSportName; // Completely different name

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.surface, scheme.surfaceVariant, scheme.surface],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildMobileNavBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 220,
                            child: _buildIllustrationSection(),
                          ),
                          const SizedBox(height: 32),
                          _buildHeadline(fontSize: 32, centered: true),
                          const SizedBox(height: 16),
                          _buildSubtitle(fontSize: 16, centered: true),
                          const SizedBox(height: 32),
                          _buildActionButtons(fullWidth: true),
                          const SizedBox(height: 24),
                          _buildAdminLoginOption(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFooter(isDesktop: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
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
              const SizedBox(width: 10),
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
          IconButton(
            onPressed: () {
              _showAdminLoginDialog(context);
            },
            icon: Icon(Icons.admin_panel_settings, color: adminColor, size: 24),
            tooltip: 'Admin Login',
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline({required double fontSize, bool centered = false}) {
    return Text(
      'Your Personalized\nSports News Hub',
      textAlign: centered ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildSubtitle({required double fontSize, bool centered = false}) {
    return Text(
      'Stay updated with the latest news, scores, and highlights from your favorite sports, leagues, teams, and players - all in one place.',
      textAlign: centered ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.6,
      ),
    );
  }

  Widget _buildActionButtons({bool fullWidth = false}) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: fullWidth ? double.infinity : null,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              );
            },
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: primaryGreen.withOpacity(0.4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: fullWidth ? double.infinity : null,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryGreen,
              side: const BorderSide(color: primaryGreen, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminLoginOption() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Text(
          'Administrator Access',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _showAdminLoginDialog(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: adminColor,
              side: BorderSide(color: adminColor, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: const Icon(Icons.admin_panel_settings, size: 20),
            label: const Text(
              'Admin / Super Admin Login',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void _showAdminLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AdminLoginDialog(
          onLogin: (role, assignedSport) {
            Navigator.pop(context);
            
            // Store admin info in state
            setState(() {
              _userRole = role;
              // Extract assigned sport name from user object
              if (role != 'super_admin' && assignedSport != null) {
                _adminSportName = assignedSport;
              }
            });
            
            if (role == 'super_admin') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuperAdminDashboardPage(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboardPage(
                    userRole: role,
                    adminSportName: assignedSport,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildIllustrationSection() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale =
                    1.0 + (index * 0.15) + (_pulseAnimation.value - 1);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 200 + (index * 80),
                    height: 200 + (index * 80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryGreen.withOpacity(0.1 - (index * 0.03)),
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          _buildFloatingSportsIcons(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryGreen, darkGreen],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryGreen.withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.sports, color: Colors.white, size: 60),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingSportsIcons() {
    final sports = [
      {'icon': Icons.sports_soccer, 'angle': 0.0},
      {'icon': Icons.sports_basketball, 'angle': math.pi / 2},
      {'icon': Icons.sports_tennis, 'angle': math.pi},
      {'icon': Icons.sports_volleyball, 'angle': 3 * math.pi / 2},
    ];

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: sports.map((sport) {
            final angle = sport['angle'] as double;
            final radius = 130.0;
            final x = math.cos(angle) * radius;
            final y = math.sin(angle) * radius;
            final bounce = math.sin(_pulseController.value * math.pi) * 5;

            return Transform.translate(
              offset: Offset(x, y + bounce),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  sport['icon'] as IconData,
                  color: primaryGreen,
                  size: 32,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFooter({required bool isDesktop}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook),
              _buildSocialIcon(Icons.telegram),
              _buildSocialIcon(Icons.email_outlined),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© 2024 SportsFeed. All rights reserved.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: primaryGreen),
      ),
    );
  }
}

// ==================== ADMIN LOGIN DIALOG ====================
class AdminLoginDialog extends StatefulWidget {
  final Function(String role, String? assignedSport) onLogin;

  const AdminLoginDialog({super.key, required this.onLogin});

  @override
  State<AdminLoginDialog> createState() => _AdminLoginDialogState();
}

class _AdminLoginDialogState extends State<AdminLoginDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'admin';
  String? _selectedSport;
  final List<String> _sports = [
    'Football',
    'Basketball',
    'Tennis',
    'Volleyball',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9C27B0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Admin Login',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'admin@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Role',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: [
                    _buildRoleChip('admin', Icons.admin_panel_settings),
                    _buildRoleChip('super_admin', Icons.supervisor_account),
                  ],
                ),
                if (_selectedRole == 'admin') ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Assigned Sport',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedSport,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    items: _sports
                        .map(
                          (sport) => DropdownMenuItem(
                            value: sport,
                            child: Text(sport),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSport = value;
                      });
                    },
                    hint: const Text('Select sport'),
                  ),
                ],
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final result = await ApiService.adminLogin(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );
                        
                        if (mounted) {
                          Navigator.pop(context);
                          
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Admin login successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          
                          // Navigate based on role
                          final role = result['role'];
                          final assignedSport = result['user']?['assigned_sport']?['name'] as String?;
                          
                          if (role == 'super_admin') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuperAdminDashboardPage(),
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminDashboardPage(
                                  userRole: role,
                                  adminSportName: assignedSport,
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login failed: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
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

  Widget _buildRoleChip(String role, IconData icon) {
    final isSelected = _selectedRole == role;
    final color = const Color(0xFF9C27B0);

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : color),
          const SizedBox(width: 6),
          Text(
            role == 'admin' ? 'Admin' : 'Super Admin',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontSize: 13,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedRole = role;
          if (role == 'super_admin') {
            _selectedSport = null;
          }
        });
      },
      selectedColor: color,
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? color : Colors.grey[300]!),
      ),
    );
  }
}

// ==================== SUPER ADMIN DASHBOARD PAGE ====================
class SuperAdminDashboardPage extends StatefulWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  State<SuperAdminDashboardPage> createState() => _SuperAdminDashboardPageState();
}

class _SuperAdminDashboardPageState extends State<SuperAdminDashboardPage> {
  final _formKey = GlobalKey<FormState>();
  final _sportFormKey = GlobalKey<FormState>();
  
  // Admin creation form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int? _selectedSportId;
  
  // Sport creation form controllers
  final _sportNameController = TextEditingController();
  final _sportDescriptionController = TextEditingController();
  final _sportIconController = TextEditingController();
  
  List<dynamic> _sports = [];
  List<dynamic> _users = [];
  bool _isLoading = false;
  bool _isLoadingUsers = false;
  int _selectedTab = 0;
  final Color _adminColor = const Color(0xFF9C27B0);

  @override
  void initState() {
    super.initState();
    _loadSports();
    _loadUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _sportNameController.dispose();
    _sportDescriptionController.dispose();
    _sportIconController.dispose();
    super.dispose();
  }

  Future<void> _loadSports() async {
    setState(() => _isLoading = true);
    try {
      final sports = await ApiService.getSportsForAssignment();
      setState(() {
        _sports = sports;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading sports: $e')),
      );
    }
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoadingUsers = true);
    try {
      final usersData = await ApiService.getAllUsers();
      setState(() {
        _users = usersData['data'] ?? [];
        _isLoadingUsers = false;
      });
    } catch (e) {
      setState(() => _isLoadingUsers = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading users: $e')),
      );
    }
  }

  Future<void> _createAdmin() async {
    if (!_formKey.currentState!.validate() || _selectedSportId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select a sport')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ApiService.createAdmin(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        assignedSportId: _selectedSportId!,
      );
      
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _selectedSportId = null;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin created successfully')),
      );
      _loadUsers();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating admin: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createSport() async {
    if (!_sportFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ApiService.createSport(
        name: _sportNameController.text,
        description: _sportDescriptionController.text.isEmpty ? null : _sportDescriptionController.text,
        icon: _sportIconController.text.isEmpty ? null : _sportIconController.text,
      );
      
      _sportNameController.clear();
      _sportDescriptionController.clear();
      _sportIconController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sport created successfully')),
      );
      _loadSports();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating sport: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      await ApiService.deleteUser(userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );
      _loadUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }

  Future<void> _deleteSport(int sportId) async {
    try {
      await ApiService.deleteSport(sportId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sport deleted successfully')),
      );
      _loadSports();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting sport: $e')),
      );
    }
  }

  Future<void> _logout() async {
    try {
      await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during logout: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _adminColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.supervisor_account,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Super Admin',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildTabContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        selectedItemColor: _adminColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Admins'),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildAdminsTab();
      case 2:
        return _buildSportsTab();
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Super Admin Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Full system access and management',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth / 2 - 20;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Total Admins',
                          '${_users.where((u) => u['role'] == 'admin').length}',
                          Icons.admin_panel_settings,
                          Colors.purple,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Total Sports',
                          '${_sports.length}',
                          Icons.sports,
                          const Color(0xFF43A047),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Total Users',
                          '${_users.length}',
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Super Admins',
                          '${_users.where((u) => u['role'] == 'super_admin').length}',
                          Icons.supervisor_account,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _buildQuickActionButton(
            'Add New Admin',
            Icons.person_add,
            _showAddAdminDialog,
          ),
          _buildQuickActionButton(
            'Add New Sport',
            Icons.add_circle_outline,
            _showAddSportDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildAdminsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _showAddAdminDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: _adminColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.person_add),
            label: const Text('Add New Admin'),
          ),
        ),
        Expanded(
          child: _isLoadingUsers
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? const Center(child: Text('No users found'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: _adminColor.withOpacity(0.1),
                              child: Icon(Icons.person, color: _adminColor),
                            ),
                            title: Text(
                              user['name'] ?? 'Unknown',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(user['email'] ?? 'No email'),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getRoleColor(user['role']).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        user['role']?.toString().toUpperCase() ?? 'UNKNOWN',
                                        style: TextStyle(
                                          color: _getRoleColor(user['role']),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    if (user['assigned_sport']?['name'] != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          user['assigned_sport']['name'],
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: user['role'] != 'super_admin'
                                ? IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _showDeleteConfirmation(user['id'], user['name']),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildSportsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _showAddSportDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: _adminColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Add New Sport'),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _sports.isEmpty
                  ? const Center(child: Text('No sports found'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _sports.length,
                      itemBuilder: (context, index) {
                        final sport = _sports[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.sports,
                                color: Colors.green,
                              ),
                            ),
                            title: Text(
                              sport['name'] ?? 'Unknown',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: sport['description'] != null
                                ? Text(sport['description'])
                                : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _showEditSportDialog(sport),
                                  icon: Icon(Icons.edit, color: _adminColor),
                                ),
                                IconButton(
                                  onPressed: () => _showDeleteSportConfirmation(sport['id'], sport['name']),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _adminColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _adminColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Color _getRoleColor(String? role) {
    switch (role) {
      case 'super_admin':
        return Colors.red;
      case 'admin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showAddAdminDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Admin'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Admin Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter admin name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Assign Sport',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSportId,
                  items: _sports.map((sport) {
                    return DropdownMenuItem<int>(
                      value: sport['id'],
                      child: Text(sport['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSportId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a sport';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _createAdmin,
            style: ElevatedButton.styleFrom(backgroundColor: _adminColor),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Create Admin'),
          ),
        ],
      ),
    );
  }

  void _showAddSportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Sport'),
        content: SingleChildScrollView(
          child: Form(
            key: _sportFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _sportNameController,
                  decoration: const InputDecoration(
                    labelText: 'Sport Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter sport name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sportDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sportIconController,
                  decoration: const InputDecoration(
                    labelText: 'Icon (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _createSport,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Create Sport'),
          ),
        ],
      ),
    );
  }

  void _showEditSportDialog(Map<String, dynamic> sport) {
    // Pre-fill the form with existing sport data
    _sportNameController.text = sport['name'] ?? '';
    _sportDescriptionController.text = sport['description'] ?? '';
    _sportIconController.text = sport['icon'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Sport'),
        content: SingleChildScrollView(
          child: Form(
            key: _sportFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _sportNameController,
                  decoration: const InputDecoration(
                    labelText: 'Sport Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter sport name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sportDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sportIconController,
                  decoration: const InputDecoration(
                    labelText: 'Icon (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : () => _updateSport(sport['id']),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Update Sport'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateSport(int sportId) async {
    if (!_sportFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ApiService.updateSport(
        id: sportId,
        name: _sportNameController.text,
        description: _sportDescriptionController.text.isEmpty ? null : _sportDescriptionController.text,
        icon: _sportIconController.text.isEmpty ? null : _sportIconController.text,
      );
      
      _sportNameController.clear();
      _sportDescriptionController.clear();
      _sportIconController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sport updated successfully')),
      );
      _loadSports();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating sport: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDeleteSportConfirmation(int sportId, String sportName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Sport'),
          content: Text('Are you sure you want to delete sport "$sportName"? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSport(sportId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(int userId, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete user "$userName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUser(userId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// ==================== ADMIN DASHBOARD PAGE (Regular Admin) ====================
class AdminDashboardPage extends StatefulWidget {
  final String? userRole;
  final String? adminSportName; // Updated variable name
  
  const AdminDashboardPage({super.key, this.userRole, this.adminSportName});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedTab = 0;
  final Color _adminColor = const Color(0xFF9C27B0);

  // Admin state variables - initialize from widget
  String? _adminSportName;
  String? _adminName;
  
  // Real data variables
  List<dynamic> _posts = [];
  List<dynamic> _sports = [];
  bool _isLoadingPosts = false;

  @override
  void initState() {
    super.initState();
    // Initialize admin info from widget
    _adminSportName = widget.adminSportName;
    _loadUserData();
    _loadSports();
    _loadPosts();
  }

  // Create Tab State
  final _createFormKey = GlobalKey<FormState>();
  final _createTitleController = TextEditingController();
  final _createDescriptionController = TextEditingController();
  final _createContentController = TextEditingController();
  XFile? _createSelectedImage;
  bool _isCreateLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _createTitleController.dispose();
    _createDescriptionController.dispose();
    _createContentController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await ApiService.getUser();
      setState(() {
        _adminName = userData['name'];
      });
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> _loadSports() async {
    try {
      final sports = await ApiService.getSports();
      setState(() {
        _sports = sports;
      });
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoadingPosts = true);
    try {
      // Get only the current admin's posts
      final myPosts = await ApiService.getMyPosts();
      setState(() {
        _posts = myPosts;
        _isLoadingPosts = false;
      });
    } catch (e) {
      setState(() => _isLoadingPosts = false);
      // Handle error silently for now
    }
  }

  Future<void> _logout() async {
    try {
      await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during logout: $e')),
        );
      }
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _adminColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (_adminSportName != null)
                Text(
                  _adminSportName!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: _logout,
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: _buildTabContent(),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: (index) {
        setState(() {
          _selectedTab = index;
        });
      },
      selectedItemColor: _adminColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Posts'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Create',
        ),
      ],
    ),
    floatingActionButton: _selectedTab == 1
        ? FloatingActionButton(
            backgroundColor: _adminColor,
            onPressed: () => _showCreatePostDialog(),
            child: const Icon(Icons.add, color: Colors.white),
          )
        : null,
  );
}

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildPostsTab();
      case 2:
        return _buildCreateTab();
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${_adminName ?? 'Admin'}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can manage posts for ${_adminSportName ?? 'your assigned sport'}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards with real data
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth / 2 - 20;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'My Posts',
                          '${_posts.length}',
                          Icons.newspaper,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Total Likes',
                          '${_posts.fold<int>(0, (sum, post) => sum + ((post['likes'] as int?) ?? 0))}',
                          Icons.thumb_up,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Today\'s Posts',
                          '${_posts.where((p) => _isToday(p['created_at'])).length}',
                          Icons.today,
                          Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _buildStatCard(
                          'Engagement',
                          '${_posts.isNotEmpty ? (_posts.fold<int>(0, (sum, post) => sum + ((post['likes'] as int?) ?? 0)) ~/ _posts.length) : 0}',
                          Icons.trending_up,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),
          Text(
            'Recent Posts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          if (_isLoadingPosts)
            const Center(child: CircularProgressIndicator())
          else if (_posts.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.newspaper,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No posts yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Create your first post for '${_adminSportName ?? 'your sport'}'",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _showCreatePostDialog(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _adminColor,
                      ),
                      child: const Text('Create First Post'),
                    ),
                  ],
                ),
              ),
            )
          else
            ..._posts.take(2).map((post) => _buildPostCard(post)).toList(),
        ],
      ),
    );
  }

  bool _isToday(String? createdAt) {
    if (createdAt == null) return false;
    try {
      final date = DateTime.parse(createdAt);
      final now = DateTime.now();
      return date.day == now.day && date.month == now.month && date.year == now.year;
    } catch (e) {
      return false;
    }
  }

  Widget _buildPostsTab() {
    if (_isLoadingPosts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.newspaper,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No posts yet',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your first post for '${_adminSportName ?? 'your sport'}'",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _buildPostCard(post);
        },
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _createFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New Post',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Create a new post for '${_adminSportName ?? 'your sport'}'",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _createTitleController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a title'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Post Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _createDescriptionController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a description'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Post Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _createContentController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter content'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Post Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    // Image Picker
                    GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          setState(() {
                            _createSelectedImage = image;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            if (_createSelectedImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(_createSelectedImage!.path),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              const Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.grey,
                              ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                _createSelectedImage != null
                                    ? 'Image selected'
                                    : 'Add Cover Image (Optional)',
                                style: TextStyle(
                                  color: _createSelectedImage != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            if (_createSelectedImage != null)
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    setState(() => _createSelectedImage = null),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isCreateLoading
                            ? null
                            : _submitCreateTabPost,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _adminColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isCreateLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Publish Post',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCreateTabPost() async {
    if (_createFormKey.currentState!.validate()) {
      setState(() => _isCreateLoading = true);
      try {
        // Find the sport ID for the admin's assigned sport
        int sportId = 1; // Default fallback
        if (_adminSportName != null && _sports.isNotEmpty) {
          final sport = _sports.firstWhere(
            (s) => s['name'].toString().toLowerCase() == _adminSportName!.toLowerCase(),
            orElse: () => _sports.first,
          );
          sportId = sport['id'] ?? 1;
        }

        await ApiService.createPost(
          title: _createTitleController.text,
          description: _createDescriptionController.text,
          content: _createContentController.text,
          sportId: sportId,
          category: 'General',
          imagePath: _createSelectedImage?.path,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('News post created successfully!')),
          );
          // Clear form
          _createTitleController.clear();
          _createDescriptionController.clear();
          _createContentController.clear();
          setState(() {
            _createSelectedImage = null;
            _selectedTab = 1; // Switch to Post list tab to see it
          });
          // Reload posts to show the new one
          _loadPosts();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to create post: $e')));
        }
      } finally {
        if (mounted) setState(() => _isCreateLoading = false);
      }
    }
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getSportColor(post['sport']?['name'] ?? 'Unknown').withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getSportIcon(post['sport']?['name'] ?? 'Unknown'),
            color: _getSportColor(post['sport']?['name'] ?? 'Unknown'),
          ),
        ),
        title: Text(
          post['title'] ?? 'Untitled',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${post['sport']?['name'] ?? 'Unknown'} • ${_formatDate(post['created_at'])}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              (post['content'] as String? ?? '').length > 100
                  ? '${(post['content'] as String? ?? '').substring(0, 100)}...'
                  : post['content'] ?? '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.thumb_up, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  '${(post['likes'] as int?) ?? 0} likes',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.person, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  post['author']?['name'] ?? 'Unknown',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showEditPostDialog(post);
                break;
              case 'delete':
                _showDeletePostConfirmation(post['id'], post['title']);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12), // Reduced padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Reduced padding
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20), // Smaller icon
            ),
            const SizedBox(height: 8), // Reduced spacing
            Text(
              value,
              style: const TextStyle(
                fontSize: 20, // Smaller font
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 11, // Smaller font
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSportColor(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return const Color(0xFF43A047);
      case 'basketball':
        return Colors.orange[700]!;
      case 'tennis':
        return Colors.yellow[800]!;
      case 'volleyball':
        return Colors.blue[700]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'volleyball':
        return Icons.sports_volleyball;
      default:
        return Icons.sports;
    }
  }

  void _showEditPostDialog(Map<String, dynamic> post) {
    // Pre-fill the form with existing post data
    _createTitleController.text = post['title'] ?? '';
    _createDescriptionController.text = post['description'] ?? '';
    _createContentController.text = post['content'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: SingleChildScrollView(
          child: Form(
            key: _createFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _createTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Post Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _createDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Post Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _createContentController,
                  decoration: const InputDecoration(
                    labelText: 'Post Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isCreateLoading ? null : () => _updatePost(post['id']),
            style: ElevatedButton.styleFrom(backgroundColor: _adminColor),
            child: _isCreateLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Update Post'),
          ),
        ],
      ),
    );
  }

  Future<void> _updatePost(int postId) async {
    if (!_createFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _isCreateLoading = true);
    try {
      // Find the sport ID for the admin's assigned sport
      int sportId = 1; // Default fallback
      if (_adminSportName != null && _sports.isNotEmpty) {
        final sport = _sports.firstWhere(
          (s) => s['name'].toString().toLowerCase() == _adminSportName!.toLowerCase(),
          orElse: () => _sports.first,
        );
        sportId = sport['id'] ?? 1;
      }

      await ApiService.updatePost(
        id: postId,
        title: _createTitleController.text,
        description: _createDescriptionController.text,
        content: _createContentController.text,
        sportId: sportId,
        category: 'General',
      );
      
      _createTitleController.clear();
      _createDescriptionController.clear();
      _createContentController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post updated successfully')),
      );
      _loadPosts();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating post: $e')),
      );
    } finally {
      setState(() => _isCreateLoading = false);
    }
  }

  void _showDeletePostConfirmation(int postId, String postTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: Text('Are you sure you want to delete post "$postTitle"? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deletePost(postId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePost(int postId) async {
    try {
      await ApiService.deletePost(postId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post deleted successfully')),
      );
      _loadPosts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting post: $e')),
      );
    }
  }

  void _showCreatePostDialog() {
    // Clear form fields
    _createTitleController.clear();
    _createDescriptionController.clear();
    _createContentController.clear();
    setState(() => _createSelectedImage = null);

    setState(() => _selectedTab = 2); // Switch to Create tab
  }
}

// ==================== DIALOGS ====================

class AddAdminDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddAdminDialog({super.key, required this.onAdd});

  @override
  State<AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<AddAdminDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedSport;
  final List<String> _sports = [
    'Football',
    'Basketball',
    'Tennis',
    'Volleyball',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9C27B0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add New Admin',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSport,
                    decoration: InputDecoration(
                      labelText: 'Assigned Sport',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: _sports
                        .map(
                          (sport) => DropdownMenuItem(
                            value: sport,
                            child: Text(sport),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSport = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a sport';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onAdd({
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'sport': _selectedSport,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9C27B0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Add Admin'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddSportDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddSportDialog({super.key, required this.onAdd});

  @override
  State<AddSportDialog> createState() => _AddSportDialogState();
}

class _AddSportDialogState extends State<AddSportDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconUrlController = TextEditingController();
  IconData? _selectedIcon;
  final List<IconData> _icons = [
    Icons.sports_soccer,
    Icons.sports_basketball,
    Icons.sports_tennis,
    Icons.sports_volleyball,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _iconUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF43A047),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add New Sport',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Sport Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sport name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Icon',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _icons.map((icon) {
                      final isSelected = _selectedIcon == icon;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIcon = icon;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF43A047).withOpacity(0.1)
                                : Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF43A047)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            icon,
                            color: isSelected
                                ? const Color(0xFF43A047)
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _iconUrlController,
                    decoration: InputDecoration(
                      labelText: 'Icon URL (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedIcon != null) {
                              widget.onAdd({
                                'name': _nameController.text,
                                'icon': _selectedIcon,
                                'icon_url': _iconUrlController.text,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Add Sport'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditSportDialog extends StatefulWidget {
  final Map<String, dynamic> sport;
  final Function(Map<String, dynamic>) onUpdate;

  const EditSportDialog({
    super.key,
    required this.sport,
    required this.onUpdate,
  });

  @override
  State<EditSportDialog> createState() => _EditSportDialogState();
}

class _EditSportDialogState extends State<EditSportDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _iconUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sport['name']);
    _iconUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF43A047),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Edit Sport',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Sport Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sport name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getSportColor(
                        _nameController.text,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.sport['icon'] as IconData,
                      color: _getSportColor(_nameController.text),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _iconUrlController,
                    decoration: InputDecoration(
                      labelText: 'New Icon URL (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onUpdate({
                                'id': widget.sport['id'],
                                'name': _nameController.text,
                                'icon': widget.sport['icon'],
                                'icon_url': _iconUrlController.text.isNotEmpty
                                    ? _iconUrlController.text
                                    : null,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Update Sport'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getSportColor(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return const Color(0xFF43A047);
      case 'basketball':
        return Colors.orange[700]!;
      case 'tennis':
        return Colors.yellow[800]!;
      case 'volleyball':
        return Colors.blue[700]!;
      default:
        return Colors.grey;
    }
  }
}

class CreatePostDialog extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic>) onPost;

  const CreatePostDialog({
    super.key,
    required this.onPost,
  });

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9C27B0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Create New Post',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Title Input
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Post Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter post title'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Body Input
                  TextFormField(
                    controller: _bodyController,
                    decoration: InputDecoration(
                      labelText: 'Post Content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter post content'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Sport Indicator
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sports,
                          color: _getSportColor('Football'),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Sport: 'All Sports'",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Add Cover Image (Optional)',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isLoading = true);

                                    try {
                                      await widget.onPost({
                                        'title': _titleController.text,
                                        'body': _bodyController.text,
                                        'image_path': _selectedImage?.path,
                                      });
                                      // Dialog closed by parent on success or we can close it here if parent doesn't
                                    } catch (e) {
                                      if (mounted) {
                                        setState(() => _isLoading = false);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text('Error: $e')),
                                        );
                                      }
                                    }
                                  }
                                },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9C27B0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Publish Post'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getSportColor(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return const Color(0xFF43A047);
      case 'basketball':
        return Colors.orange[700]!;
      case 'tennis':
        return Colors.yellow[800]!;
      case 'volleyball':
        return Colors.blue[700]!;
      default:
        return Colors.grey;
    }
  }
}
