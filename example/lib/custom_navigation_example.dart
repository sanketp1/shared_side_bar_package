import 'package:example/nav_items.dart';
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';

ThemeMode _themeMode = ThemeMode.light;

class CustomNavigationExample extends StatefulWidget {
  const CustomNavigationExample({super.key});

  @override
  State<CustomNavigationExample> createState() =>
      _CustomNavigationExampleState();
}

class _CustomNavigationExampleState extends State<CustomNavigationExample> {
  int _selectedIndex = 0;

  final SidebarUser _user = SidebarUser(
    name: 'Jane Smith',
    email: 'jane.smith@company.com',
    onProfileTap: () => print('Profile tapped'),
    onLogoutTap: () => print('Logout tapped'),
  );

  Widget _customHeader(bool isExpanded, VoidCallback onToggleExpand) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: isExpanded ? 16 : 12),
      decoration: BoxDecoration(
        color: _themeMode == ThemeMode.light
            ? AppTheme.primaryBlue
            : Colors.black45,
        // gradient: LinearGradient(
        //   colors: [Colors.blue.shade800, Colors.purple.shade600],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: isExpanded
          ? Row(
              children: [
                Icon(Icons.business, color: Colors.white, size: 32),
                SizedBox(width: 12),
                Text(
                  'My Company',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: onToggleExpand,
                  icon: Icon(Icons.menu_open, color: Colors.white),
                ),
              ],
            )
          : Center(
              child: IconButton(
                onPressed: onToggleExpand,
                icon: Icon(Icons.menu, color: Colors.white),
              ),
            ),
    );
  }

  Widget _customFooter(bool isExpanded, SidebarUser? user) {
    return Container(
      padding: EdgeInsets.all(isExpanded ? 16 : 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: isExpanded
          ? Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    user?.initials ?? 'JS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'User',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user?.email ?? 'email@example.com',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Badge(
                  smallSize: 8,
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          : Center(
              child: Badge(
                smallSize: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    user?.initials ?? 'JS',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
    );
  }

  void _onItemTapped(int index, String path) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSideNavigationBar(
      items: navigationItems,
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      sidebarHeader: _customHeader,
      sidebarFooter: _customFooter,
      navigationTheme: NavigationTheme(
        backgroundColor: _themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black87,
      ),
      user: _user,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: _themeMode == ThemeMode.light
              ? AppTheme.primaryBlue
              : Colors.white,
          elevation: 2,
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: _themeMode == ThemeMode.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    _themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: _themeMode == ThemeMode.light
                        ? Colors.white
                        : AppTheme.black,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: _toggleTheme,
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: _buildDashboardContent(context),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Text(
            'Welcome back, John! 👋',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s what\'s happening with your projects today.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _StatsCard(
                    title: 'Total Projects',
                    value: '24',
                    icon: Icons.folder,
                    color: AppTheme.primaryBlue,
                    width: isWide
                        ? (constraints.maxWidth - 48) / 3
                        : constraints.maxWidth,
                  ),
                  _StatsCard(
                    title: 'Active Tasks',
                    value: '156',
                    icon: Icons.task_alt,
                    color: AppTheme.primaryBlue,
                    width: isWide
                        ? (constraints.maxWidth - 48) / 3
                        : constraints.maxWidth,
                  ),
                  _StatsCard(
                    title: 'Team Members',
                    value: '12',
                    icon: Icons.people,
                    color: AppTheme.primaryBlue,
                    width: isWide
                        ? (constraints.maxWidth - 48) / 3
                        : constraints.maxWidth,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Features Section
          Text(
            'Navigation Features',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _FeatureCard(
            icon: Icons.phone_android,
            title: 'Responsive Design',
            description:
                'Automatically switches between sidebar (tablet/desktop) and bottom navigation (mobile) based on screen width.',
          ),
          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.animation,
            title: 'Smooth Transitions',
            description:
                'Fade and slide animations ensure seamless transitions when resizing the window or changing orientations.',
          ),
          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.palette,
            title: 'Theme Matching',
            description:
                'Both sidebar and bottom nav use identical styling, colors, and animations to maintain design consistency.',
          ),
          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.touch_app,
            title: 'Tactile Feedback',
            description:
                'Tap animations, scale effects, and visual feedback provide a premium user experience.',
          ),
          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.notifications,
            title: 'Badge Support',
            description:
                'Display notification counts on navigation items with customizable badge styling.',
          ),
          const SizedBox(height: 32),

          // Instructions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.primaryBlue),
                    const SizedBox(width: 12),
                    Text(
                      'Try it out!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Resize your browser window to see the navigation adapt\n'
                  '• Click navigation items to see smooth transitions\n'
                  '• Toggle the sidebar collapse button on desktop\n'
                  '• Notice the matching design between sidebar and bottom nav',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 100), // Extra space for bottom nav
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double width;

  const _StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.gray800 : AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.gray700 : AppTheme.gray200),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppTheme.black : AppTheme.gray900).withOpacity(
              0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(title, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.gray800 : AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.gray700 : AppTheme.gray200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTheme {
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
}
