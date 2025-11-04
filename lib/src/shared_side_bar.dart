/// Responsive shell that orchestrates the sidebar (desktop/tablet)
/// and bottom navigation (mobile), including smooth transitions when
/// crossing the configured breakpoint.
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';

/// A responsive navigation shell that shows a collapsible sidebar on
/// wide screens and a bottom navigation bar on mobile.
///
/// {@template responsive_side_navigation_bar}
/// The `ResponsiveSideNavigationBar` widget provides a complete responsive
/// navigation solution that automatically adapts to screen size changes.
/// It orchestrates smooth transitions between sidebar (desktop/tablet)
/// and bottom navigation (mobile) layouts with sophisticated animations.
///
/// **Key Features:**
/// - Automatic layout switching based on screen width breakpoint
/// - Smooth scale and fade animations during layout transitions
/// - Cross-fading between sidebar and bottom navigation
/// - Customizable transition timing and curves
/// - Flexible sidebar and bottom bar customization
/// - Maintains navigation state during layout changes
///
/// **Transition Behavior:**
/// - Main content scales and fades during layout changes
/// - Sidebar smoothly collapses/expands with size animations
/// - Bottom navigation slides up/down with opacity changes
/// - All transitions synchronized with the same duration and curve
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// ResponsiveSideNavigationBar(
///   child: MyHomePage(),
///   items: navItems,
///   selectedIndex: currentIndex,
///   onItemTapped: (index, path) => navigateTo(path),
///   tabletBreakpoint: 768,
///   user: currentUser,
///   appName: 'MyApp',
/// )
/// ```
///
/// See also:
/// - [ModernSidebar], the sidebar component used on desktop/tablet
/// - [CustomBottomNavBar], the bottom navigation used on mobile
/// - [NavigationUtils], for responsive layout detection
/// - [NavigationTheme], for consistent theming across components
class ResponsiveSideNavigationBar extends StatefulWidget {
  /// Creates a responsive navigation shell with smooth layout transitions.
  ///
  /// {@template responsive_side_navigation_bar_constructor}
  /// Requires [child] and [items] to be non-null. The widget automatically
  /// manages layout transitions between sidebar and bottom navigation
  /// based on the screen width and configured breakpoint.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [child] - The main content widget to display alongside navigation
  /// [items] - List of navigation items for both sidebar and bottom navigation
  /// [selectedIndex] - The currently selected navigation item index
  /// [onItemTapped] - Callback when a navigation item is tapped
  /// [tabletBreakpoint] - Width threshold for mobile/tablet layout switching
  /// [transitionDuration] - Duration for layout transition animations
  /// [transitionCurve] - Curve for layout transition animations
  /// [navigationTheme] - Optional custom theme for navigation components
  /// [sidebarHeader] - Custom header builder for the sidebar
  /// [sidebarFooter] - Custom footer builder for the sidebar
  /// [user] - User information for the sidebar footer
  /// [logo] - Custom logo widget for the sidebar header
  /// [appName] - Application name for the sidebar header
  ///
  /// ## Example
  /// ```dart
  /// ResponsiveSideNavigationBar(
  ///   key: ValueKey('responsive_nav'),
  ///   child: HomeScreen(),
  ///   items: [
  ///     NavItem(label: 'Home', path: '/home', icon: Icons.home),
  ///     NavItem(label: 'Profile', path: '/profile', icon: Icons.person),
  ///   ],
  ///   selectedIndex: _currentIndex,
  ///   onItemTapped: (index, path) {
  ///     setState(() => _currentIndex = index);
  ///     Navigator.pushNamed(context, path);
  ///   },
  ///   tabletBreakpoint: 1024,
  ///   transitionDuration: Duration(milliseconds: 500),
  ///   user: currentUser,
  ///   appName: 'MyApplication',
  /// )
  /// ```
  const ResponsiveSideNavigationBar({
    super.key,
    required this.child,
    required this.items,
    this.selectedIndex = 0,
    this.onItemTapped,
    this.tabletBreakpoint = 768,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.transitionCurve = Curves.easeInOutCubic,
    this.navigationTheme,
    this.sidebarHeader,
    this.sidebarFooter,
    this.user,
    this.logo,
    this.appName,
  });

  /// The main content widget to display alongside navigation.
  ///
  /// This widget occupies the primary content area and is displayed
  /// alongside the sidebar on desktop/tablet or below the bottom
  /// navigation on mobile.
  final Widget child;

  /// List of navigation items for both sidebar and bottom navigation.
  ///
  /// The same navigation items are used in both layout modes, ensuring
  /// consistent navigation structure across different screen sizes.
  final List<NavItem> items;

  /// The currently selected navigation item index.
  ///
  /// Determines which item appears as active in both sidebar and
  /// bottom navigation layouts. Defaults to 0.
  final int selectedIndex;

  /// Callback invoked when a navigation item is tapped.
  ///
  /// Provides both the tapped item's index and route path. This callback
  /// is used for both sidebar and bottom navigation interactions.
  final void Function(int index, String path)? onItemTapped;

  /// Width threshold for mobile/tablet layout switching.
  ///
  /// When the screen width is below this value, mobile layout (bottom
  /// navigation) is used. Above this value, tablet/desktop layout
  /// (sidebar) is used. Defaults to 768.0 (common tablet breakpoint).
  final double tabletBreakpoint;

  /// Duration for layout transition animations.
  ///
  /// Controls how long it takes to animate between different layout
  /// states when the screen size crosses the breakpoint. Defaults
  /// to 400 milliseconds.
  final Duration transitionDuration;

  /// Curve for layout transition animations.
  ///
  /// Defines the timing curve used for all layout transition animations.
  /// Defaults to [Curves.easeInOutCubic] for smooth, natural transitions.
  final Curve transitionCurve;

  /// Optional custom theme for navigation components.
  ///
  /// Applied to both sidebar and bottom navigation for consistent
  /// styling. If not provided, uses adaptive theming based on the
  /// current theme brightness.
  final NavigationTheme? navigationTheme;

  /// Custom header builder for the sidebar.
  ///
  /// If provided, overrides the default sidebar header with custom
  /// content. Receives the current expansion state and toggle callback.
  final Widget Function(bool isExpanded, VoidCallback onToggleExpand)?
      sidebarHeader;

  /// Custom footer builder for the sidebar.
  ///
  /// If provided, overrides the default sidebar footer with custom
  /// content. Receives the current expansion state and user information.
  final Widget Function(bool isExpanded, SidebarUser? user)? sidebarFooter;

  /// User information for the sidebar footer.
  ///
  /// Displayed in the sidebar footer when expanded. Includes avatar,
  /// name, and email with optional tap callbacks.
  final SidebarUser? user;

  /// Custom logo widget for the sidebar header.
  ///
  /// If provided, replaces the default gradient logo in the sidebar
  /// header with custom content.
  final Widget? logo;

  /// Application name for the sidebar header.
  ///
  /// Displayed next to the logo in the expanded sidebar header.
  /// Shown as tooltip in collapsed state.
  final String? appName;

  @override
  State<ResponsiveSideNavigationBar> createState() =>
      _ResponsiveSideNavigationBarState();
}

class _ResponsiveSideNavigationBarState
    extends State<ResponsiveSideNavigationBar>
    with SingleTickerProviderStateMixin {
  /// Controller for managing layout transition animations.
  ///
  /// Coordinates the scale and fade animations during layout changes
  /// when crossing the breakpoint threshold.
  late AnimationController _transitionController;

  /// Animation for opacity transitions during layout changes.
  ///
  /// Fades from 0.0 to 1.0 to create smooth appearance/disappearance
  /// effects during layout transitions.
  late Animation<double> _opacityAnimation;

  /// Animation for scale transitions during layout changes.
  ///
  /// Scales from 0.95 to 1.0 to create subtle zoom effects that
  /// emphasize layout changes.
  late Animation<double> _scaleAnimation;

  /// Whether the current layout should use mobile mode.
  ///
  /// Determined by comparing current screen width against the
  /// [widget.tabletBreakpoint] threshold.
  bool _isMobile = false;

  /// The previous mobile state for detecting layout changes.
  ///
  /// Used to determine when to trigger transition animations.
  bool _previousIsMobile = false;

  /// Whether a layout transition animation is currently in progress.
  ///
  /// Prevents multiple simultaneous transitions and ensures clean
  /// animation state management.
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initializes the animation controllers and animations.
  ///
  /// {@template responsive_side_navigation_bar_initialize_animations}
  /// Sets up the transition animation system:
  /// - [_transitionController]: Manages the transition timeline
  /// - [_opacityAnimation]: Fade from 0.0 to 1.0
  /// - [_scaleAnimation]: Scale from 0.95 to 1.0
  /// - Starts with animations completed (value = 1.0)
  /// {@endtemplate}
  void _initializeAnimations() {
    _transitionController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    _opacityAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _transitionController,
            curve: widget.transitionCurve,
          ),
        );

    _scaleAnimation =
        Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _transitionController,
            curve: widget.transitionCurve,
          ),
        );

    _transitionController.value = 1.0;
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  /// Handles layout changes and triggers transition animations.
  ///
  /// {@template responsive_side_navigation_bar_handle_layout_change}
  /// Detects when the layout mode changes (mobile ↔ desktop/tablet)
  /// and triggers the transition animation if not already in progress.
  /// Updates the previous state tracking after animation completion.
  /// {@endtemplate}
  ///
  /// [isMobile] - The new layout mode (true for mobile, false for desktop/tablet)
  void _handleLayoutChange(bool isMobile) {
    if (_previousIsMobile != isMobile && !_isTransitioning) {
      _isTransitioning = true;
      _transitionController.forward(from: 0.0).then((_) {
        _isTransitioning = false;
      });
      _previousIsMobile = isMobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        widget.navigationTheme ??
        NavigationUtils.getAdaptiveNavigationTheme(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        _isMobile = NavigationUtils.isMobileLayout(
          constraints,
          widget.tabletBreakpoint,
        );
        _handleLayoutChange(_isMobile);

        return AnimatedBuilder(
          animation: _transitionController,
          builder: (context, child) {
            return Scaffold(
              body: Stack(
                children: [
                  // Main content with smooth scale and fade
                  Positioned.fill(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: Row(
                          children: [
                            // Sidebar for desktop/tablet with smooth size + fade
                            AnimatedSize(
                              duration: widget.transitionDuration,
                              curve: widget.transitionCurve,
                              child: AnimatedSwitcher(
                                duration: widget.transitionDuration,
                                switchInCurve: widget.transitionCurve,
                                switchOutCurve: widget.transitionCurve,
                                child: _isMobile
                                    ? const SizedBox(
                                        width: 0,
                                        height: double.infinity,
                                      )
                                    : ModernSidebar(
                                        key: const ValueKey('modern-sidebar'),
                                        items: widget.items,
                                        selectedIndex: widget.selectedIndex,
                                        onItemTapped: widget.onItemTapped,
                                        navigationTheme: theme,
                                        sidebarHeader: widget.sidebarHeader,
                                        sidebarFooter: widget.sidebarFooter,
                                        user: widget.user,
                                        logo: widget.logo,
                                        appName: widget.appName,
                                      ),
                              ),
                            ),

                            // Main content area
                            Expanded(
                              child: widget.child,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom navigation overlay for mobile (appears on top during transition)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      duration: widget.transitionDuration,
                      curve: widget.transitionCurve,
                      opacity: _isMobile || _isTransitioning ? 1.0 : 0.0,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          _isMobile || _isTransitioning ? 0 : 100,
                        ),
                        child: IgnorePointer(
                          ignoring: !_isMobile,
                          child: CustomBottomNavBar(
                            items: widget.items,
                            selectedIndex: widget.selectedIndex,
                            onItemTapped: widget.onItemTapped,
                            navigationTheme: theme,
                            isOverlay: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}