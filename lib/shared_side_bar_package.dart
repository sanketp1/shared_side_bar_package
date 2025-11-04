/// Shared Side Bar Package
///
/// A comprehensive Flutter package for implementing responsive navigation
/// with modern sidebar and bottom navigation components.
///
/// {@template shared_side_bar_package}
/// The Shared Side Bar Package provides a complete solution for building
/// responsive navigation in Flutter applications. It features adaptive
/// layout behavior that automatically switches between a modern collapsible
/// sidebar for large screens and an animated bottom navigation bar for
/// mobile devices.
///
/// **Package Features:**
/// - Responsive layout adaptation based on screen size
/// - Modern collapsible sidebar with smooth animations
/// - Animated bottom navigation bar with badge support
/// - Customizable theming system
/// - High-performance state management
/// - Accessibility and internationalization support
/// - Smooth cross-platform transitions
///
/// **Architecture:**
/// - **Models**: Data structures for navigation items, themes, and user info
/// - **Widgets**: Reusable UI components for sidebar and bottom navigation
/// - **Utils**: Helper functions for responsive behavior and theming
/// - **Main Export**: Complete responsive navigation shell
/// {@endtemplate}
///
/// ## Quick Start
///
/// ```dart
/// import 'package:shared_side_bar_package/shared_side_bar_package.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ResponsiveSideNavigationBar(
///       child: MyHomePage(),
///       items: navigationItems,
///       selectedIndex: currentIndex,
///       onItemTapped: (index, path) => navigateTo(path),
///       user: currentUser,
///       appName: 'My Application',
///     );
///   }
/// }
/// ```
///
/// ## Core Components
///
/// - [ResponsiveSideNavigationBar] - Main responsive navigation shell
/// - [NavItem] - Navigation item data model
/// - [NavigationTheme] - Theming configuration
/// - [ModernSidebar] - Collapsible sidebar widget
/// - [CustomBottomNavBar] - Bottom navigation widget
///
/// See also:
/// - [https://flutter.dev](https://flutter.dev) for Flutter framework documentation
/// - [https://api.flutter.dev](https://api.flutter.dev) for Flutter API reference
library shared_side_bar_package;

/// Main responsive navigation shell that orchestrates the entire package.
///
/// {@template main_export}
/// The primary entry point for most applications. This widget automatically
/// manages the responsive behavior, switching between sidebar and bottom
/// navigation based on screen size with smooth animated transitions.
/// {@endtemplate}
export 'src/models/nav_item.dart';
export 'src/models/navigation_theme.dart';
export 'src/models/side_bar_user.dart';
export 'src/shared_side_bar.dart';
export 'src/utils/navigation_utils.dart';
export 'src/widgets/bottom_nav_item.dart';
export 'src/widgets/custom_bottom_nav_bar.dart';
export 'src/widgets/modern_sidebar.dart';
export 'src/widgets/navigation_badge.dart';
export 'src/widgets/sidebar_nav_item.dart';
