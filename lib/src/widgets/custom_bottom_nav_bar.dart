/// Animated bottom navigation bar for mobile screens.
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';
import 'bottom_nav_item.dart';
import '../models/navigation_theme.dart';

/// Animated bottom navigation bar used on mobile screens.
///
/// {@template custom_bottom_nav_bar}
/// The `CustomBottomNavBar` widget provides a fully-featured bottom navigation
/// bar optimized for mobile devices. It features smooth slide animations,
/// customizable theming, badge support, and an optional overlay mode for
/// use during layout transitions.
///
/// **Key Features:**
/// - Smooth slide-in/slide-out animations
/// - Support for badge counts on navigation items
/// - Customizable theming and colors
/// - Overlay mode for floating above content
/// - Safe area integration
/// - Responsive item distribution
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// CustomBottomNavBar(
///   items: navItems,
///   selectedIndex: currentIndex,
///   onItemTapped: (index, path) => navigateTo(path),
///   navigationTheme: NavigationTheme(),
///   isOverlay: false,
/// )
/// ```
///
/// See also:
/// - [BottomNavItem], the individual navigation items used in this bar
/// - [NavigationTheme], for customizing the visual appearance
/// - [BottomNavigationBar], Flutter's built-in bottom navigation
/// - [SafeArea], for handling device notches and safe zones
class CustomBottomNavBar extends StatefulWidget {
  /// Creates an animated bottom navigation bar.
  ///
  /// {@template custom_bottom_nav_bar_constructor}
  /// Requires [items] and [selectedIndex] to be non-null. The [onItemTapped]
  /// callback is optional but typically provided to handle navigation.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [items] - List of navigation items to display
  /// [selectedIndex] - The currently selected item index
  /// [onItemTapped] - Callback when an item is tapped (index and path provided)
  /// [navigationTheme] - Optional custom theme for styling
  /// [isOverlay] - Whether the bar should appear as an overlay without background shadow
  ///
  /// ## Example
  /// ```dart
  /// CustomBottomNavBar(
  ///   key: ValueKey('bottom_nav'),
  ///   items: [
  ///     NavItem(label: 'Home', path: '/home', icon: Icons.home, activeIcon: Icons.home_filled),
  ///     NavItem(label: 'Search', path: '/search', icon: Icons.search, activeIcon: Icons.search),
  ///   ],
  ///   selectedIndex: _currentIndex,
  ///   onItemTapped: (index, path) {
  ///     setState(() => _currentIndex = index);
  ///     Navigator.pushNamed(context, path);
  ///   },
  ///   isOverlay: true,
  /// )
  /// ```
  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onItemTapped,
    this.navigationTheme,
    this.isOverlay = false,
  });

  /// List of navigation items to display in the bar.
  ///
  /// Each item will be rendered as a [BottomNavItem] with equal distribution
  /// across the available width. Typically contains 3-5 items for optimal
  /// mobile usability.
  final List<NavItem> items;

  /// The index of the currently selected navigation item.
  ///
  /// This determines which item appears in the active state with
  /// the selection indicator and active styling.
  final int selectedIndex;

  /// Callback invoked when a navigation item is tapped.
  ///
  /// Provides both the tapped item's index and route path for convenience.
  /// If not provided, items will still animate but no action will occur.
  final void Function(int index, String path)? onItemTapped;

  /// Optional custom theme for navigation bar styling.
  ///
  /// Controls colors, shadows, and background appearance. If not provided,
  /// falls back to theme defaults from [Theme.of(context)].
  final NavigationTheme? navigationTheme;

  /// Whether the navigation bar should appear as an overlay.
  ///
  /// When `true`:
  /// - Background shadow is removed for floating appearance
  /// - Useful during layout transitions or when bar overlays content
  ///
  /// When `false` (default):
  /// - Standard shadow is applied for elevation separation
  /// - Typical bottom navigation bar appearance
  final bool isOverlay;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  /// Controller for the bar's visibility animations.
  ///
  /// Manages the 250ms slide animation when the navigation bar appears
  /// or disappears from view.
  late AnimationController _visibilityController;

  /// Animation for the slide transition of the navigation bar.
  ///
  /// Slides from bottom (Offset(0, 1)) to normal position (Offset.zero)
  /// with an ease-in-out curve.
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  /// Initializes the animation controllers and animations.
  ///
  /// {@template custom_bottom_nav_bar_setup_animations}
  /// Sets up the slide animation system:
  /// - [_visibilityController]: 250ms duration for slide transitions
  /// - [_slideAnimation]: Slide from bottom to normal position
  /// - Automatically starts the slide-in animation on initialization
  /// {@endtemplate}
  void _setupAnimations() {
    _visibilityController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _visibilityController,
            curve: Curves.easeInOut,
          ),
        );

    _visibilityController.forward();
  }

  @override
  void dispose() {
    _visibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.navigationTheme;

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color:
              theme?.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            if (!widget.isOverlay)
              BoxShadow(
                color: theme?.shadowColor ?? Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -1),
              ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.items.length, (index) {
                final item = widget.items[index];
                final isSelected = widget.selectedIndex == index;

                return Expanded(
                  child: BottomNavItem(
                    item: item,
                    isSelected: isSelected,
                    navigationTheme: theme,
                    onTap: () {
                      widget.onItemTapped?.call(index, item.path);
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}