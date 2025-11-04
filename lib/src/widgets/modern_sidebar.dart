/// High-performance collapsible sidebar with ValueNotifier - Fixed Constraint Animation
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';
import 'package:shared_side_bar_package/src/models/side_bar_user.dart';
import 'sidebar_nav_item.dart';
import '../models/navigation_theme.dart';

/// A high-performance collapsible sidebar with smooth animations and flexible customization.
///
/// {@template modern_sidebar}
/// The `ModernSidebar` widget provides a fully-featured navigation sidebar
/// that can collapse and expand with smooth animations. It features:
/// - High-performance ValueNotifier-based state management
/// - Fixed constraint animations for smooth transitions
/// - Customizable header and footer sections
/// - Badge support for notification counts
/// - Responsive design with tooltips in collapsed state
/// - Flexible theming system
///
/// **Performance Features:**
/// - ValueNotifier for efficient state propagation
/// - Fixed width constraints for stable animations
/// - Optimized rebuilds with ValueListenableBuilder
/// - Efficient list rendering with ListView.builder
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// ModernSidebar(
///   items: navItems,
///   selectedIndex: currentIndex,
///   onItemTapped: (index, path) => navigateTo(path),
///   user: currentUser,
///   appName: 'MyApp',
/// )
/// ```
///
/// See also:
/// - [SidebarNavItem], for individual sidebar navigation items
/// - [NavigationTheme], for customizing sidebar appearance
/// - [SidebarUser], for user information in the footer
/// - [ValueNotifier], for efficient state management
class ModernSidebar extends StatefulWidget {
  /// Creates a high-performance collapsible sidebar.
  ///
  /// {@template modern_sidebar_constructor}
  /// Requires [items] and [selectedIndex] to be non-null. The sidebar
  /// supports extensive customization through optional parameters for
  /// header, footer, user info, and theming.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [items] - List of navigation items to display in the sidebar
  /// [selectedIndex] - The currently selected navigation item index
  /// [onItemTapped] - Callback when a navigation item is tapped
  /// [navigationTheme] - Optional custom theme for styling
  /// [sidebarHeader] - Custom header builder (overrides default header)
  /// [sidebarFooter] - Custom footer builder (overrides default footer)
  /// [user] - User information for the footer section
  /// [logo] - Custom logo widget (overrides default gradient logo)
  /// [appName] - Application name displayed in the header
  ///
  /// ## Example
  /// ```dart
  /// ModernSidebar(
  ///   key: ValueKey('main_sidebar'),
  ///   items: navigationItems,
  ///   selectedIndex: _selectedIndex,
  ///   onItemTapped: (index, path) {
  ///     setState(() => _selectedIndex = index);
  ///     Navigator.pushNamed(context, path);
  ///   },
  ///   user: currentUser,
  ///   appName: 'MyApplication',
  ///   logo: FlutterLogo(size: 40),
  ///   navigationTheme: customTheme,
  /// )
  /// ```
  const ModernSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onItemTapped,
    this.navigationTheme,
    this.sidebarHeader,
    this.sidebarFooter,
    this.user,
    this.logo,
    this.appName = 'YourApp',
  });

  /// List of navigation items to display in the sidebar.
  ///
  /// Each item is rendered as a interactive navigation element with
  /// support for badges, icons, and selection states. The items are
  /// displayed in a scrollable list when the sidebar is expanded.
  final List<NavItem> items;

  /// The index of the currently selected navigation item.
  ///
  /// Determines which item appears in the active state with
  /// highlighted background, border, and colored icon/text.
  final int selectedIndex;

  /// Callback invoked when a navigation item is tapped.
  ///
  /// Provides both the tapped item's index and route path for
  /// convenient navigation handling.
  final void Function(int index, String path)? onItemTapped;

  /// Optional custom theme for sidebar styling.
  ///
  /// Controls colors, backgrounds, and visual appearance. If not provided,
  /// falls back to theme defaults from [Theme.of(context)].
  final NavigationTheme? navigationTheme;

  /// Custom header builder for the sidebar.
  ///
  /// If provided, overrides the default header with custom content.
  /// Receives the current expansion state and a toggle callback.
  final Widget Function(bool isExpanded, VoidCallback onToggleExpand)?
  sidebarHeader;

  /// Custom footer builder for the sidebar.
  ///
  /// If provided, overrides the default footer with custom content.
  /// Receives the current expansion state and user information.
  final Widget Function(bool isExpanded, SidebarUser? user)? sidebarFooter;

  /// User information displayed in the footer section.
  ///
  /// Shows user avatar, name, and email when expanded. Falls back to
  /// a default "John Doe" user if not provided.
  final SidebarUser? user;

  /// Custom logo widget for the header.
  ///
  /// If provided, replaces the default gradient logo with custom content.
  /// Typically a [FlutterLogo], [Image], or custom [Container].
  final Widget? logo;

  /// Application name displayed in the header when expanded.
  ///
  /// Shown next to the logo in the expanded state. Defaults to 'YourApp'.
  final String? appName;

  @override
  State<ModernSidebar> createState() => _ModernSidebarState();
}

class _ModernSidebarState extends State<ModernSidebar> {
  /// Notifier for managing the sidebar expansion state.
  ///
  /// Controls whether the sidebar is expanded (280px) or collapsed (72px)
  /// with efficient value propagation to listeners.
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(true);

  /// Width of the sidebar when fully expanded.
  static const double _expandedWidth = 280.0;

  /// Width of the sidebar when collapsed.
  static const double _collapsedWidth = 72.0;

  /// Duration for the sidebar expansion/collapse animations.
  static const Duration _duration = Duration(milliseconds: 250);

  @override
  void dispose() {
    _isExpandedNotifier.dispose();
    super.dispose();
  }

  /// Toggles the sidebar between expanded and collapsed states.
  ///
  /// {@template modern_sidebar_toggle_expanded}
  /// Switches the expansion state and triggers the width animation
  /// through the ValueNotifier, which efficiently updates all listeners.
  /// {@endtemplate}
  void _toggleExpanded() {
    _isExpandedNotifier.value = !_isExpandedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.navigationTheme;
    final bgColor =
        theme?.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final borderColor = theme?.borderColor ?? Colors.grey.shade300;
    final shadowColor = Colors.black.withOpacity(0.08);

    return ValueListenableBuilder<bool>(
      valueListenable: _isExpandedNotifier,
      builder: (context, isExpanded, _) {
        final currentWidth = isExpanded ? _expandedWidth : _collapsedWidth;

        return Container(
          width: currentWidth,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(
              right: BorderSide(
                color: borderColor.withOpacity(0.6),
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 8.0,
                offset: const Offset(2, 0),
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:
                    widget.sidebarHeader?.call(isExpanded, _toggleExpanded) ??
                    _buildHeader(context, theme, borderColor, isExpanded),
              ),
              Expanded(
                child: _buildNavigationItems(context, isExpanded),
              ),
              widget.sidebarFooter?.call(isExpanded, widget.user) ??
                  _buildFooter(context, theme, borderColor, isExpanded),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    NavigationTheme? theme,
    Color borderColor,
    bool isExpanded,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: borderColor.withOpacity(0.4),
                width: 0.5,
              ),
            ),
          ),
          child: SizedBox(
            height: 72,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: isExpanded
                  ? _buildExpandedHeader(context, theme)
                  : _buildCollapsedHeader(theme),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExpandedHeader(BuildContext context, NavigationTheme? theme) {
    return Row(
      children: [
        _buildLogo(theme),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.appName!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (theme?.inactiveColor ?? Colors.grey.shade600).withOpacity(
                0.3,
              ),
              width: 1.0,
            ),
          ),
          child: IconButton(
            onPressed: _toggleExpanded,
            icon: Icon(
              Icons.menu_open,
              color: theme?.inactiveColor ?? Colors.grey.shade600,
              size: 18,
            ),
            tooltip: 'Collapse',
            splashRadius: 18,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedHeader(NavigationTheme? theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: (theme?.inactiveColor ?? Colors.grey.shade600)
                    .withOpacity(0.2),
                width: 1.0,
              ),
            ),
            child: _buildLogo(theme),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: (theme?.inactiveColor ?? Colors.grey.shade600)
                    .withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: IconButton(
              onPressed: _toggleExpanded,
              icon: Icon(
                Icons.menu,
                color: theme?.inactiveColor ?? Colors.grey.shade600,
                size: 18,
              ),
              tooltip: 'Expand',
              splashRadius: 16,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(NavigationTheme? theme) {
    return widget.logo ??
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme?.activeColor ?? Colors.blue.shade700,
                theme?.activeColor.withOpacity(0.7) ?? Colors.blue.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: (theme?.activeColor ?? Colors.blue.shade700).withOpacity(
                  0.3,
                ),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.rocket_launch,
            color: Colors.white,
            size: 24,
          ),
        );
  }

  Widget _buildNavigationItems(BuildContext context, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final isSelected = widget.selectedIndex == index;
          return _buildNavItem(item, index, isSelected, isExpanded);
        },
      ),
    );
  }

  Widget _buildNavItem(
    NavItem item,
    int index,
    bool isSelected,
    bool isExpanded,
  ) {
    final theme = widget.navigationTheme;
    final activeColor = theme?.activeColor ?? Colors.blue.shade700;
    final inactiveColor = theme?.inactiveColor ?? Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: () => widget.onItemTapped?.call(index, item.path),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(
                    color: activeColor.withOpacity(0.4),
                    width: 1.5,
                  )
                : Border.all(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: isExpanded
              ? _buildExpandedNavItem(
                  item,
                  isSelected,
                  activeColor,
                  inactiveColor,
                )
              : _buildCollapsedNavItem(
                  item,
                  isSelected,
                  activeColor,
                  inactiveColor,
                ),
        ),
      ),
    );
  }

  Widget _buildExpandedNavItem(
    NavItem item,
    bool isSelected,
    Color activeColor,
    Color inactiveColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? activeColor.withOpacity(0.1)
                  : inactiveColor.withOpacity(0.05),
              border: Border.all(
                color: isSelected
                    ? activeColor.withOpacity(0.3)
                    : Colors.transparent,
                width: 1.0,
              ),
            ),
            child: Icon(
              item.icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
                letterSpacing: -0.2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (item.badgeCount > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              constraints: const BoxConstraints(
                minWidth: 20,
                maxHeight: 20,
              ),
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                item.badgeCount > 99 ? '99+' : item.badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCollapsedNavItem(
    NavItem item,
    bool isSelected,
    Color activeColor,
    Color inactiveColor,
  ) {
    return Center(
      child: Tooltip(
        message: item.label,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(8),

              child: Icon(
                item.icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 20,
              ),
            ),
            if (item.badgeCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeColor.withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Center(
                    child: Text(
                      item.badgeCount > 9 ? '9+' : item.badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    NavigationTheme? theme,
    Color borderColor,
    bool isExpanded,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: borderColor.withOpacity(0.4),
                width: 0.5,
              ),
            ),
          ),
          child: SizedBox(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: isExpanded
                  ? _buildExpandedFooter(context, theme)
                  : _buildCollapsedFooter(theme),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedFooter(BuildContext context, NavigationTheme? theme) {
    final user =
        widget.user ??
        const SidebarUser(
          name: 'John Doe',
          email: 'john@example.com',
        );

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (theme?.activeColor ?? Colors.blue.shade700).withOpacity(
                0.3,
              ),
              width: 1.5,
            ),
          ),
          child: GestureDetector(
            onTap: user.onProfileTap,
            child: _buildAvatar(user, theme),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (theme?.inactiveColor ?? Colors.grey.shade600).withOpacity(
                0.3,
              ),
              width: 1.0,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.logout,
              size: 18,
              color: theme?.inactiveColor ?? Colors.grey.shade600,
            ),
            onPressed: user.onLogoutTap ?? () {},
            tooltip: 'Logout',
            splashRadius: 16,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedFooter(NavigationTheme? theme) {
    final user =
        widget.user ??
        const SidebarUser(
          name: 'John Doe',
          email: 'john@example.com',
        );

    return Center(
      child: Tooltip(
        message: user.name,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (theme?.activeColor ?? Colors.blue.shade700).withOpacity(
                0.3,
              ),
              width: 1.5,
            ),
          ),
          child: GestureDetector(
            onTap: user.onProfileTap,
            child: _buildAvatar(user, theme),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(SidebarUser user, NavigationTheme? theme) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: theme?.activeColor ?? Colors.blue.shade700,
      child: Text(
        user.initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
