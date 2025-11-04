/// Sidebar list item with selection state, badge, and tap animation.
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';
import 'package:shared_side_bar_package/src/widgets/navigation_badge.dart';
import '../models/navigation_theme.dart';

/// A single item in the sidebar with selection state, badge, and tap animation.
///
/// {@template sidebar_nav_item}
/// The `SidebarNavItem` widget represents an individual navigation item
/// within a sidebar. It provides rich interactive features including:
/// - Smooth tap scale animations for tactile feedback
/// - Selection state with visual indicators
/// - Badge support for notification counts
/// - Adaptive layout for expanded and collapsed sidebar states
/// - Accessibility support with semantic labels
/// - Smooth transitions between all visual states
///
/// **Animation Features:**
/// - Scale animation on tap (100ms)
/// - Smooth layout transitions (200ms)
/// - Icon switching with scale transitions
/// - Selection indicator animations
/// - Text style transitions
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// SidebarNavItem(
///   item: navItem,
///   index: 0,
///   isSelected: currentIndex == 0,
///   isExpanded: true,
///   navigationTheme: NavigationTheme(),
///   onTap: () => onItemTapped(0),
/// )
/// ```
///
/// See also:
/// - [ModernSidebar], the parent sidebar component
/// - [NavigationBadge], for displaying notification counts
/// - [NavItem], the data model for navigation items
/// - [NavigationTheme], for customizing visual appearance
class SidebarNavItem extends StatefulWidget {
  /// Creates a sidebar navigation item with interactive features.
  ///
  /// {@template sidebar_nav_item_constructor}
  /// Requires all parameters to be non-null. The widget automatically
  /// adapts its layout based on the [isExpanded] state and provides
  /// visual feedback through animations and selection states.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [item] - The navigation item data to display
  /// [index] - The position index of this item in the navigation list
  /// [isSelected] - Whether this item is currently selected
  /// [isExpanded] - Whether the sidebar is in expanded or collapsed state
  /// [navigationTheme] - Optional custom theme for styling
  /// [onTap] - Callback when the item is tapped
  ///
  /// ## Example
  /// ```dart
  /// SidebarNavItem(
  ///   key: ValueKey('home_nav_item'),
  ///   item: NavItem(
  ///     label: 'Home',
  ///     path: '/home',
  ///     icon: Icons.home_outlined,
  ///     activeIcon: Icons.home_filled,
  ///     badgeCount: 3,
  ///   ),
  ///   index: 0,
  ///   isSelected: selectedIndex == 0,
  ///   isExpanded: isSidebarExpanded,
  ///   navigationTheme: customTheme,
  ///   onTap: () => setState(() => selectedIndex = 0),
  /// )
  /// ```
  const SidebarNavItem({
    super.key,
    required this.item,
    required this.index,
    required this.isSelected,
    required this.isExpanded,
    required this.navigationTheme,
    required this.onTap,
  });

  /// The navigation item data to display.
  ///
  /// Contains all necessary information including label, icons, badge count,
  /// and accessibility data. Determines the visual representation and
  /// behavior of the navigation item.
  final NavItem item;

  /// The position index of this item in the navigation list.
  ///
  /// Used for identification and typically passed to the [onTap] callback
  /// to indicate which item was selected.
  final int index;

  /// Whether this item is currently selected.
  ///
  /// When `true`, the item displays with:
  /// - Active icon variant
  /// - Selection indicator (vertical bar in expanded, horizontal in collapsed)
  /// - Background highlight with opacity
  /// - Border accent
  /// - Bold text weight
  /// - Active color theme
  final bool isSelected;

  /// Whether the sidebar is in expanded or collapsed state.
  ///
  /// Determines the layout behavior:
  /// - `true`: Full layout with icon, text, and badge horizontally
  /// - `false`: Compact layout with centered icon and vertical badge
  final bool isExpanded;

  /// Optional custom theme for navigation item styling.
  ///
  /// Controls active/inactive colors and visual appearance. If not provided,
  /// falls back to [Theme.of(context).primaryColor] and grey shades.
  final NavigationTheme? navigationTheme;

  /// Callback invoked when this navigation item is tapped.
  ///
  /// Typically used to update the selected index or navigate to the
  /// corresponding route. Only triggered if [NavItem.enabled] is `true`.
  final VoidCallback onTap;

  @override
  State<SidebarNavItem> createState() => _SidebarNavItemState();
}

class _SidebarNavItemState extends State<SidebarNavItem>
    with SingleTickerProviderStateMixin {
  /// Controller for the tap scale animation.
  ///
  /// Manages the 100ms scale animation that provides tactile feedback
  /// when the item is pressed and released.
  late AnimationController _tapController;

  /// Animation for the scale transform during tap interactions.
  ///
  /// Scales from 1.0 (normal) to 0.95 (pressed) with an ease-in-out curve
  /// to create natural tactile feedback.
  late Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initializes the animation controllers and animations.
  ///
  /// {@template sidebar_nav_item_initialize_animations}
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

  /// Handles the tap down event to start the scale animation.
  ///
  /// {@template sidebar_nav_item_handle_tap_down}
  /// Triggers the scale animation when the user presses down on the item,
  /// creating immediate visual feedback that the item is being interacted with.
  /// {@endtemplate}
  void _handleTapDown(TapDownDetails details) {
    _tapController.forward();
  }

  /// Handles the tap up event to reverse the scale animation.
  ///
  /// {@template sidebar_nav_item_handle_tap_up}
  /// Reverses the scale animation when the user releases the tap,
  /// returning the item to its normal size. The actual navigation
  /// action is triggered after this animation completes.
  /// {@endtemplate}
  void _handleTapUp(TapUpDetails details) {
    _tapController.reverse();
  }

  /// Handles tap cancellation to reverse the scale animation.
  ///
  /// {@template sidebar_nav_item_handle_tap_cancel}
  /// Ensures the scale animation is reversed if the tap is cancelled
  /// (e.g., user drags away before releasing), maintaining consistent
  /// visual behavior.
  /// {@endtemplate}
  void _handleTapCancel() {
    _tapController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.navigationTheme;
    final activeColor = theme?.activeColor ?? Theme.of(context).primaryColor;
    final inactiveColor = theme?.inactiveColor ?? Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Semantics(
        label: widget.item.semanticLabel ?? widget.item.label,
        selected: widget.isSelected,
        enabled: widget.item.enabled,
        button: true,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.item.enabled ? widget.onTap : null,
          child: AnimatedBuilder(
            animation: _tapAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _tapAnimation.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(widget.isExpanded ? 12 : 8),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? activeColor.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: widget.isSelected
                    ? Border.all(color: activeColor.withOpacity(0.2))
                    : null,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: widget.isExpanded
                    ? _buildExpandedLayout(activeColor, inactiveColor)
                    : _buildCollapsedLayout(activeColor, inactiveColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the expanded layout for the sidebar navigation item.
  ///
  /// {@template sidebar_nav_item_build_expanded_layout}
  /// Creates the horizontal layout used when the sidebar is expanded:
  /// - Selection indicator (vertical bar on left)
  /// - Icon with badge overlay
  /// - Text label with animated style
  /// - All elements arranged in a row
  /// {@endtemplate}
  ///
  /// [activeColor] - The color to use for selected state elements
  /// [inactiveColor] - The color to use for unselected state elements
  Widget _buildExpandedLayout(Color activeColor, Color inactiveColor) {
    return Row(
      key: const ValueKey('expanded-layout'),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isSelected ? 3 : 0,
          height: 24,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: widget.isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  widget.isSelected ? widget.item.activeIcon : widget.item.icon,
                  key: ValueKey('${widget.isSelected}-${widget.item.label}'),
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
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 15,
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              color: widget.isSelected ? activeColor : inactiveColor,
            ),
            child: Text(
              widget.item.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the collapsed layout for the sidebar navigation item.
  ///
  /// {@template sidebar_nav_item_build_collapsed_layout}
  /// Creates the compact vertical layout used when the sidebar is collapsed:
  /// - Selection indicator (horizontal bar above icon)
  /// - Centered icon with badge overlay
  /// - No text label (tooltip shows on hover)
  /// - All elements arranged in a column
  /// {@endtemplate}
  ///
  /// [activeColor] - The color to use for selected state elements
  /// [inactiveColor] - The color to use for unselected state elements
  Widget _buildCollapsedLayout(Color activeColor, Color inactiveColor) {
    return Center(
      key: const ValueKey('collapsed-layout'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.isSelected ? 24 : 0,
            height: 3,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: widget.isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    widget.isSelected
                        ? widget.item.activeIcon
                        : widget.item.icon,
                    key: ValueKey(
                      '${widget.isSelected}-${widget.item.label}-collapsed',
                    ),
                    color: widget.isSelected ? activeColor : inactiveColor,
                    size: 26,
                  ),
                ),
                if (widget.item.badgeCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: NavigationBadge(count: widget.item.badgeCount),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}