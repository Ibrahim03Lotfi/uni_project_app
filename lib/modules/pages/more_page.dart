import 'package:flutter/material.dart';
import 'package:sports_news_app/data/notifiers.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color lightGreen = Color(0xFF81C784);

  // User data
  String _userName = "John Smith";
  String _userEmail = "john.smith@example.com";
  String _userPhone = "+1 (555) 123-4567";
  String _userBio = "Sports enthusiast | Football fan | NBA lover";

  // Settings
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPlayVideos = false;
  bool _showLiveScores = true;
  String _selectedLanguage = "English";
  String _selectedFavoriteSport = "Football";

  final List<String> _languages = [
    "English",
    "Spanish",
    "French",
    "Arabic",
    "German",
  ];
  final List<String> _sports = [
    "Football",
    "Basketball",
    "Tennis",
    "Volleyball",
    "All Sports",
  ];

  late final VoidCallback _darkModeListener;

  @override
  void initState() {
    super.initState();

    _darkModeEnabled = isDarkModeNotifier.value;
    _darkModeListener = () {
      if (!mounted) return;
      setState(() {
        _darkModeEnabled = isDarkModeNotifier.value;
      });
    };
    isDarkModeNotifier.addListener(_darkModeListener);
  }

  @override
  void dispose() {
    isDarkModeNotifier.removeListener(_darkModeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Profile Section
              _buildProfileSection(),
              // Settings Section
              _buildSettingsSection(),
              // Logout Button
              _buildLogoutButton(),
              const SizedBox(height: 20),
            ],
          ),
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
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Profile & Settings',
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
            child: const Text(
              'PRO',
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
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
                // Profile Picture
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: primaryGreen, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      _userName.split(' ').map((n) => n[0]).join(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _userBio,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Edit Button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _editProfile,
                    icon: Icon(Icons.edit, color: primaryGreen, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey, height: 1),
          // Profile Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileDetailItem(
                  icon: Icons.email_outlined,
                  title: 'Email Address',
                  value: _userEmail,
                  onTap: () => _editField('Email', _userEmail, (value) {
                    setState(() {
                      _userEmail = value;
                    });
                  }),
                ),
                const SizedBox(height: 12),
                _buildProfileDetailItem(
                  icon: Icons.phone_outlined,
                  title: 'Phone Number',
                  value: _userPhone,
                  onTap: () => _editField('Phone Number', _userPhone, (value) {
                    setState(() {
                      _userPhone = value;
                    });
                  }),
                ),
                const SizedBox(height: 12),
                _buildProfileDetailItem(
                  icon: Icons.info_outline,
                  title: 'Bio',
                  value: _userBio,
                  onTap: () => _editField('Bio', _userBio, (value) {
                    setState(() {
                      _userBio = value;
                    });
                  }),
                ),
                const SizedBox(height: 12),
                _buildProfileDetailItem(
                  icon: Icons.password_outlined,
                  title: 'Password',
                  value: '********',
                  onTap: _changePassword,
                  showChevron: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    bool showChevron = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Icon(icon, color: primaryGreen, size: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (showChevron)
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: const Icon(
                    Icons.settings_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Notification Settings
                _buildSettingItem(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive match updates and news alerts',
                  isSwitch: true,
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Dark Mode
                _buildSettingItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  isSwitch: true,
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });

                    setDarkMode(value);
                  },
                ),
                const SizedBox(height: 12),
                // Auto-play Videos
                _buildSettingItem(
                  icon: Icons.videocam_outlined,
                  title: 'Auto-play Videos',
                  subtitle: 'Play videos automatically',
                  isSwitch: true,
                  value: _autoPlayVideos,
                  onChanged: (value) {
                    setState(() {
                      _autoPlayVideos = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Live Scores
                _buildSettingItem(
                  icon: Icons.live_tv_outlined,
                  title: 'Show Live Scores',
                  subtitle: 'Display live scores on home screen',
                  isSwitch: true,
                  value: _showLiveScores,
                  onChanged: (value) {
                    setState(() {
                      _showLiveScores = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Language Selection
                _buildSettingItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'App language',
                  isDropdown: true,
                  dropdownValue: _selectedLanguage,
                  items: _languages,
                  onChangedDropdown: (value) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Favorite Sport
                _buildSettingItem(
                  icon: Icons.favorite_outline,
                  title: 'Favorite Sport',
                  subtitle: 'Default sport for home screen',
                  isDropdown: true,
                  dropdownValue: _selectedFavoriteSport,
                  items: _sports,
                  onChangedDropdown: (value) {
                    setState(() {
                      _selectedFavoriteSport = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Privacy Policy
                _buildSettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'View our privacy policy',
                  isAction: true,
                  onTap: _viewPrivacyPolicy,
                ),
                const SizedBox(height: 12),
                // Terms of Service
                _buildSettingItem(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  subtitle: 'View terms and conditions',
                  isAction: true,
                  onTap: _viewTermsOfService,
                ),
                const SizedBox(height: 12),
                // Help & Support
                _buildSettingItem(
                  icon: Icons.help_outline_outlined,
                  title: 'Help & Support',
                  subtitle: 'Get help or contact support',
                  isAction: true,
                  onTap: _contactSupport,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isSwitch = false,
    bool isDropdown = false,
    bool isAction = false,
    bool? value,
    String? dropdownValue,
    List<String>? items,
    Function(bool)? onChanged,
    Function(String)? onChangedDropdown,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Icon(icon, color: primaryGreen, size: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (isSwitch && value != null)
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: primaryGreen,
                  activeTrackColor: primaryGreen.withOpacity(0.5),
                )
              else if (isDropdown && dropdownValue != null && items != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    underline: const SizedBox(),
                    icon: Icon(Icons.arrow_drop_down, color: primaryGreen),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null && onChangedDropdown != null) {
                        onChangedDropdown(value);
                      }
                    },
                  ),
                )
              else if (isAction)
                Icon(Icons.chevron_right, color: primaryGreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _confirmLogout,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.red[700], size: 20),
                const SizedBox(width: 12),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Action Methods
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: _userName),
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: _userEmail),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _userEmail = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: _userBio),
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  hintText: 'Tell us about yourself...',
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _userBio = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackbar('Profile updated successfully');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editField(
    String fieldName,
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $fieldName'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter new $fieldName',
            border: const OutlineInputBorder(),
          ),
          maxLines: fieldName == 'Bio' ? 3 : 1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              _showSuccessSnackbar('$fieldName updated successfully');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                _showErrorSnackbar('Passwords do not match');
              } else if (newPasswordController.text.isEmpty) {
                _showErrorSnackbar('Please enter a new password');
              } else {
                Navigator.pop(context);
                _showSuccessSnackbar('Password changed successfully');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _viewPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Privacy Policy'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Text(
                'Privacy Policy Content\n\n'
                '1. Information We Collect\n'
                'We collect information you provide directly to us, such as when you create an account, update your profile, or contact us for support.\n\n'
                '2. How We Use Your Information\n'
                'We use the information we collect to provide, maintain, and improve our services, to develop new ones, and to protect SportsFeed and our users.\n\n'
                '3. Information Sharing\n'
                'We do not share your personal information with companies, organizations, or individuals outside of SportsFeed except in the following cases...\n\n'
                '4. Data Security\n'
                'We work hard to protect SportsFeed and our users from unauthorized access to or unauthorized alteration, disclosure, or destruction of information we hold.\n\n'
                '5. Changes to This Policy\n'
                'We may change this privacy policy from time to time. We will post any privacy policy changes on this page.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _viewTermsOfService() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Terms of Service'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Text(
                'Terms of Service\n\n'
                '1. Acceptance of Terms\n'
                'By accessing and using SportsFeed, you accept and agree to be bound by the terms and provision of this agreement.\n\n'
                '2. Description of Service\n'
                'SportsFeed provides sports news, match schedules, and related content. The service is provided "as is" and "as available".\n\n'
                '3. User Responsibilities\n'
                'You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer or device.\n\n'
                '4. Prohibited Uses\n'
                'You may not use SportsFeed for any illegal or unauthorized purpose. You must not violate any laws in your jurisdiction.\n\n'
                '5. Termination\n'
                'We may terminate or suspend your account immediately, without prior notice, for any reason whatsoever.\n\n'
                '6. Changes to Terms\n'
                'We reserve the right to modify these terms at any time. We will provide notice of any significant changes.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _contactSupport() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSupportOption(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@sportsfeed.com',
              onTap: () => _openEmail(),
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
              icon: Icons.phone_outlined,
              title: 'Call Support',
              subtitle: '+1 (800) 123-4567',
              onTap: () => _makePhoneCall(),
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
              icon: Icons.chat_outlined,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              onTap: () => _startLiveChat(),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Icon(icon, color: primaryGreen, size: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // Perform logout logic here
    _showSuccessSnackbar('Logged out successfully');
    // Navigate to login screen or home
    // Navigator.pushReplacementNamed(context, '/login');
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: primaryGreen),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _openEmail() {
    Navigator.pop(context);
    _showSuccessSnackbar('Email app will open to support@sportsfeed.com');
  }

  void _makePhoneCall() {
    Navigator.pop(context);
    _showSuccessSnackbar('Calling +1 (800) 123-4567...');
  }

  void _startLiveChat() {
    Navigator.pop(context);
    _showSuccessSnackbar('Opening live chat...');
  }
}
