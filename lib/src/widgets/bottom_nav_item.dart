/// Bottom navigation item with selection state and optional badge.
/// 
/// A highly interactive bottom navigation item with smooth animations,
/// badge support, and adaptive theming for modern mobile navigation.
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/src/models/nav_item.dart';
import 'package:shared_side_bar_package/src/widgets/navigation_badge.dart';

import '../models/navigation_theme.dart';

/// A single bottom navigation item with selection state and badge support.
///
/// {@template bottom_nav_item}
/// The `BottomNavItem` widget represents an individual item in a bottom
/// navigation bar. It provides rich visual feedback including:
/// - Smooth icon transitions between active/inactive states
/// - Tap scale animations for interactive feedback
/// - Badge display for notification counts
/// - Adaptive theming with customizable colors
/// - Selection indicator with animated width
/// - Text style transitions for selected state
///
/// **Visual Features:**
/// - Scale animation on tap for tactile feedback
/// - Animated selection indicator bar
/// - Icon switching with scale transition
/// - Badge positioning for notification counts
/// - Smooth color and style transitions
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// BottomNavItem(
///   item: NavItem(
///     label: 'Home',
///     path: '/home',
///     icon: Icons.home_outlined,
///     activeIcon: Icons.home_filled,
///     badgeCount: 3,
///   ),
///   isSelected: currentIndex == 0,
///   navigationTheme: NavigationTheme(),
///   onTap: () => onItemTapped(0),
/// )
/// ```
///
/// See also:
/// - [BottomNavigationBar], Flutter's built-in bottom navigation
/// - [NavItem], the data model for navigation items
/// - [NavigationBadge], the badge component for notifications
/// - [NavigationTheme], the theming system for navigation components
class BottomNavItem extends StatefulWidget {

  
  /// Creates a bottom navigation item.
  ///
  /// {@template bottom_nav_item_constructor}
  /// Requires [item], [isSelected], and [onTap] to be non-null.
  /// The [navigationTheme] is optional and provides custom styling.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [item] - The navigation item data to display
  /// [isSelected] - Whether this item is currently active
  /// [navigationTheme] - Optional custom theme for styling
  /// [onTap] - Callback when the item is tapped
  ///
  /// ## Example
  /// ```dart
  /// BottomNavItem(
  ///   key: ValueKey('home_nav_item'),
  ///   item: homeNavItem,
  ///   isSelected: selectedIndex == 0,
  ///   navigationTheme: customTheme,
  ///   onTap: () => setState(() => selectedIndex = 0),
  /// )
  /// ```
  const BottomNavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.navigationTheme,
    required this.onTap,
  });
  

  /// The navigation item data to display.
  ///
  /// Contains all the necessary information for the navigation item
  /// including labels, icons, badge count, and accessibility data.
  final NavItem item;

  /// Whether this item is currently selected.
  ///
  /// When `true`, the item will display in its active state with:
  /// - Active icon variant
  /// - Selection indicator bar
  /// - Bold text weight
  /// - Active color theme
  final bool isSelected;

  /// Optional custom theme for navigation styling.
  ///
  /// If provided, uses custom colors for active/inactive states.
  /// If `null`, falls back to [Theme.of(context).primaryColor] and
  /// [Colors.grey.shade600] for default styling.
  final NavigationTheme? navigationTheme;

  /// Callback invoked when this navigation item is tapped.
  ///
  /// Typically used to update the current selected index or navigate
  /// to the corresponding route. The tap includes visual feedback
  /// animations.
  final VoidCallback onTap;

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem>
    with SingleTickerProviderStateMixin {
  /// Controller for the tap scale animation.
  ///
  /// Manages the 100ms scale animation that provides tactile feedback
  /// when the item is pressed.
  late AnimationController _tapController;

  /// Animation for the scale transform during tap interactions.
  ///
  /// Scales from 1.0 (normal) to 0.95 (pressed) with an ease-in-out curve.
  late Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initializes the animation controllers and animations.
  ///
  /// {@template bottom_nav_item_initialize_animations}
  /// Sets up the tap animation system:
  /// - [_tapController]: 100ms duration for press feedback
  /// - [_tapAnimation]: Scale from 1.0 to 0.95 with ease-in-out curve
  /// {@endtemplate}
  void _initializeAnimations() {
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _tapAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(
          CurvedAnimation(
            parent: _tapController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.navigationTheme;
    final activeColor = theme?.activeColor ?? Theme.of(context).primaryColor;
    final inactiveColor = theme?.inactiveColor ?? Colors.grey.shade600;

    return GestureDetector(
      onTapDown: (_) => _tapController.forward(),
      onTapUp: (_) => _tapController.reverse(),
      onTapCancel: () => _tapController.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _tapAnimation,
        builder: (context, child) => Transform.scale(
          scale: _tapAnimation.value,
          child: child,
        ),
        child: _buildNavigationItem(activeColor, inactiveColor),
      ),
    );
  }

  /// Builds the main navigation item content.
  ///
  /// {@template bottom_nav_item_build_navigation_item}
  /// Constructs the complete navigation item with:
  /// - Selection indicator bar (animated width)
  /// - Icon with badge support (animated switching)
  /// - Label text (animated style)
  /// {@endtemplate}
  ///
  /// [activeColor] - The color to use for selected state
  /// [inactiveColor] - The color to use for unselected state
  ///
  /// Returns the composed navigation item widget tree.
  Widget _buildNavigationItem(Color activeColor, Color inactiveColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSelectionIndicator(activeColor),
        _buildIconWithBadge(activeColor, inactiveColor),
        _buildLabel(activeColor, inactiveColor),
      ],
    );
  }

  /// Builds the animated selection indicator bar.
  ///
  /// {@template bottom_nav_item_build_selection_indicator}
  /// Creates a thin bar that appears below the icon when selected.
  /// - Animated width: 45px when selected, 0px when not selected
  /// - 200ms animation duration for smooth transitions
  /// - Rounded corners for visual polish
  /// {@endtemplate}
  ///
  /// [activeColor] - The color for the selection indicator
  Widget _buildSelectionIndicator(Color activeColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 4),
      height: 3,
      width: widget.isSelected ? 45 : 0,
      decoration: BoxDecoration(
        color: widget.isSelected ? activeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  /// Builds the icon with optional badge overlay.
  ///
  /// {@template bottom_nav_item_build_icon_with_badge}
  /// Creates an icon stack with:
  /// - [AnimatedSwitcher] for smooth icon transitions
  /// - Scale transition between active/inactive icons
  /// - [NavigationBadge] positioned for notification counts
  /// - 200ms animation duration for icon changes
  /// {@endtemplate}
  ///
  /// [activeColor] - The color for the active icon
  /// [inactiveColor] - The color for the inactive icon
  Widget _buildIconWithBadge(Color activeColor, Color inactiveColor) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Icon(
            widget.isSelected
                ? widget.item.activeIcon
                : widget.item.icon,
            key: ValueKey(widget.isSelected),
            color: widget.isSelected ? activeColor : inactiveColor,
            size: 24,
          ),
        ),
        if (widget.item.badgeCount > 0)
          Positioned(
            right: -8,
            top: -4,
            child: NavigationBadge(count: widget.item.badgeCount),
          ),
      ],
    );
  }

  /// Builds the animated label text.
  ///
  /// {@template bottom_nav_item_build_label}
  /// Creates the text label with:
  /// - [AnimatedDefaultTextStyle] for smooth style transitions
  /// - Font weight change (w600 selected, w400 unselected)
  /// - Color transitions between active/inactive states
  /// - 11px font size optimized for bottom navigation
  /// - 200ms animation duration for style changes
  /// {@endtemplate}
  ///
  /// [activeColor] - The color for the active label
  /// [inactiveColor] - The color for the inactive label
  Widget _buildLabel(Color activeColor, Color inactiveColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 11,
          fontWeight: widget.isSelected
              ? FontWeight.w600
              : FontWeight.w400,
          color: widget.isSelected ? activeColor : inactiveColor,
        ),
        child: Text(widget.item.label),
      ),
    );
  }
}