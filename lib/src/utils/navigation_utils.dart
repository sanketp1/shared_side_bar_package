/// Helpers for responsive breakpoints and adaptive navigation theme.
/// 
/// Provides utility methods for responsive layout detection and adaptive
/// theming based on screen size and platform brightness.
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/src/models/navigation_theme.dart';

/// Utilities for responsive navigation behavior and adaptive theming.
///
/// {@template navigation_utils}
/// The `NavigationUtils` class provides static helper methods for common
/// navigation-related tasks including responsive layout detection, adaptive
/// color selection, and theme adaptation based on platform brightness.
///
/// **Key Features:**
/// - Responsive layout breakpoint detection
/// - Adaptive color selection for light/dark themes
/// - Automatic navigation theme adaptation
/// - Static utility methods (no instantiation needed)
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return LayoutBuilder(
///     builder: (context, constraints) {
///       final isMobile = NavigationUtils.isMobileLayout(
///         constraints, 
///         768.0,
///       );
///       final theme = NavigationUtils.getAdaptiveNavigationTheme(context);
///       
///       return isMobile ? BottomNavBar(theme: theme) : SideBar(theme: theme);
///     },
///   );
/// }
/// ```
///
/// See also:
/// - [LayoutBuilder], for obtaining parent constraints
/// - [MediaQuery], for screen size information
/// - [Theme], for accessing current theme data
class NavigationUtils {
  // Private constructor to prevent instantiation
  NavigationUtils._();

  /// Determines if the current layout should use mobile navigation patterns.
  ///
  /// {@template navigation_utils_is_mobile_layout}
  /// This method evaluates the available layout constraints against a
  /// breakpoint to determine if mobile-style navigation (e.g., bottom
  /// navigation bar) should be used instead of desktop-style navigation
  /// (e.g., sidebar).
  ///
  /// **Typical Breakpoint Values:**
  /// - Mobile: < 768.0 (tablet portrait and smaller)
  /// - Tablet: 768.0 - 1024.0
  /// - Desktop: > 1024.0
  /// {@endtemplate}
  ///
  /// [constraints] - The [BoxConstraints] from [LayoutBuilder] or parent container
  /// [breakpoint] - The width threshold below which mobile layout is used
  ///
  /// Returns `true` if the layout width is less than the breakpoint, indicating
  /// mobile layout should be used.
  ///
  /// ## Example
  /// ```dart
  /// LayoutBuilder(
  ///   builder: (context, constraints) {
  ///     final isMobile = NavigationUtils.isMobileLayout(
  ///       constraints, 
  ///       768.0, // Common mobile breakpoint
  ///     );
  ///     
  ///     if (isMobile) {
  ///       return BottomNavigationBar(items: navItems);
  ///     } else {
  ///       return NavigationRail(items: navItems);
  ///     }
  ///   },
  /// )
  /// ```
  static bool isMobileLayout(BoxConstraints constraints, double breakpoint) {
    return constraints.maxWidth < breakpoint;
  }

  /// Selects the appropriate color based on the current theme brightness.
  ///
  /// {@template navigation_utils_get_adaptive_color}
  /// This method returns the appropriate color variant based on the current
  /// theme brightness. It's useful for ensuring proper contrast and visual
  /// hierarchy in both light and dark themes without manual brightness checks.
  ///
  /// **Common Use Cases:**
  /// - Text colors that need to adapt to background brightness
  /// - Icon colors that should invert in dark mode
  /// - Border colors that need different opacity levels
  /// - Background colors for adaptive containers
  /// {@endtemplate}
  ///
  /// [context] - The build context to access the current theme
  /// [light] - The color to use when the theme is [Brightness.light]
  /// [dark] - The color to use when the theme is [Brightness.dark]
  ///
  /// Returns the appropriate color for the current theme brightness.
  ///
  /// ## Example
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Container(
  ///     color: NavigationUtils.getAdaptiveColor(
  ///       context,
  ///       Colors.black,      // Use black text in light mode
  ///       Colors.white,      // Use white text in dark mode
  ///     ),
  ///     child: Text('Adaptive Color Text'),
  ///   );
  /// }
  /// ```
  static Color getAdaptiveColor(BuildContext context, Color light, Color dark) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }

  /// Creates an adaptive navigation theme based on the current theme brightness.
  ///
  /// {@template navigation_utils_get_adaptive_navigation_theme}
  /// This method returns a [NavigationTheme] that automatically adapts to
  /// the current platform brightness. It uses the default [NavigationTheme]
  /// constructor for light theme and [NavigationTheme.forDarkTheme()] for
  /// dark theme.
  ///
  /// **Benefits:**
  /// - Automatic light/dark theme switching
  /// - Consistent with platform appearance settings
  /// - No manual theme brightness checks needed
  /// - Uses pre-configured dark theme optimizations
  /// {@endtemplate}
  ///
  /// [context] - The build context to access the current theme brightness
  ///
  /// Returns a [NavigationTheme] configured for the current brightness.
  ///
  /// ## Example
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   final adaptiveTheme = NavigationUtils.getAdaptiveNavigationTheme(context);
  ///   
  ///   return SideBar(
  ///     theme: adaptiveTheme,
  ///     items: navItems,
  ///   );
  /// }
  /// ```
  ///
  /// See also:
  /// - [NavigationTheme], the theme model being adapted
  /// - [NavigationTheme.forDarkTheme], the dark theme variant method
  static NavigationTheme getAdaptiveNavigationTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final baseTheme = NavigationTheme();
    return brightness == Brightness.dark ? baseTheme.forDarkTheme() : baseTheme;
  }


}