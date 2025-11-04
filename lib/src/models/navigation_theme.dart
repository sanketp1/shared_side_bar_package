/// Theming model for navigation colors and motion.
/// 
/// Provides a comprehensive theming system for navigation components with
/// built-in support for light and dark theme variants.
import 'package:flutter/material.dart';

/// Visual configuration theme for navigation components.
///
/// {@template navigation_theme}
/// The `NavigationTheme` class encapsulates all visual and motion properties
/// needed to style navigation components consistently across the application.
/// It provides colors for different states, background, surfaces, and
/// animation parameters for transitions.
///
/// **Key Features:**
/// - Complete color system for navigation states
/// - Animation timing and curve configuration
/// - Built-in dark theme variant
/// - Immutable with copy functionality
/// - Sensible default values for quick setup
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// const lightTheme = NavigationTheme(
///   activeColor: Colors.blue,
///   inactiveColor: Colors.grey,
///   backgroundColor: Colors.white,
/// );
///
/// final darkTheme = lightTheme.forDarkTheme();
/// ```
///
/// See also:
/// - [BottomNavigationBarTheme], Flutter's built-in bottom navigation theming
/// - [NavigationRailTheme], Flutter's built-in navigation rail theming
/// - [Theme], the overall theme data for Material Design apps
class NavigationTheme {
  /// Creates a navigation theme with the given visual properties.
  ///
  /// {@template navigation_theme_constructor}
  /// All parameters are optional and have sensible default values optimized
  /// for light theme applications. Use [forDarkTheme()] to get a pre-configured
  /// dark theme variant.
  /// {@endtemplate}
  ///
  /// [activeColor] - The color used for active/selected navigation items
  /// [inactiveColor] - The color used for inactive/unselected navigation items  
  /// [backgroundColor] - The background color of the navigation container
  /// [surfaceColor] - The color used for surfaces within the navigation
  /// [borderColor] - The color used for borders and dividers
  /// [shadowColor] - The color used for shadows and elevations
  /// [transitionDuration] - The duration for navigation transition animations
  /// [transitionCurve] - The curve for navigation transition animations
  ///
  /// ## Example
  /// ```dart
  /// const customTheme = NavigationTheme(
  ///   activeColor: Color(0xFF007AFF),
  ///   inactiveColor: Color(0xFF8E8E93),
  ///   backgroundColor: Color(0xFFF2F2F7),
  ///   transitionDuration: Duration(milliseconds: 200),
  ///   transitionCurve: Curves.easeOut,
  /// );
  /// ```
  const NavigationTheme({
    this.activeColor = const Color(0xFF1E3A8A),
    this.inactiveColor = const Color(0xFF6B7280),
    this.backgroundColor = Colors.white,
    this.surfaceColor = const Color(0xFFF9FAFB),
    this.borderColor = const Color(0xFFE5E7EB),
    this.shadowColor = const Color(0x0A000000),
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.easeInOut,
  });

  /// The color used for active/selected navigation items.
  ///
  /// This color is typically applied to:
  /// - Selected icon tints
  /// - Active text labels
  /// - Selection indicators
  /// - Focus highlights
  ///
  /// Defaults to `Color(0xFF1E3A8A)` (a deep blue).
  final Color activeColor;

  /// The color used for inactive/unselected navigation items.
  ///
  /// This color is typically applied to:
  /// - Unselected icon tints
  /// - Inactive text labels
  /// - Disabled states
  ///
  /// Defaults to `Color(0xFF6B7280)` (a medium gray).
  final Color inactiveColor;

  /// The background color of the navigation container.
  ///
  /// This is the primary background color for the entire navigation
  /// component (sidebar, bottom nav bar, etc.).
  ///
  /// Defaults to `Colors.white`.
  final Color backgroundColor;

  /// The color used for surfaces within the navigation component.
  ///
  /// This color is typically used for:
  /// - Elevated sections
  /// - Card backgrounds within navigation
  /// - Secondary background areas
  ///
  /// Defaults to `Color(0xFFF9FAFB)` (a very light gray).
  final Color surfaceColor;

  /// The color used for borders and dividers.
  ///
  /// This color is applied to:
  /// - Separation lines between items
  /// - Container borders
  /// - Divider elements
  ///
  /// Defaults to `Color(0xFFE5E7EB)` (a light gray).
  final Color borderColor;

  /// The color used for shadows and elevation effects.
  ///
  /// This color is used when the navigation component has elevation
  /// or shadow effects. Typically has low opacity to create subtle
  /// shadow effects.
  ///
  /// Defaults to `Color(0x0A000000)` (black with 4% opacity).
  final Color shadowColor;

  /// The duration for navigation transition animations.
  ///
  /// Controls how long it takes for navigation state changes to animate,
  /// including:
  /// - Active state transitions
  /// - Selection indicator movements
  /// - Color transitions
  ///
  /// Defaults to `300 milliseconds`.
  final Duration transitionDuration;

  /// The curve for navigation transition animations.
  ///
  /// Defines the timing curve used for all navigation animations.
  /// Common curves include [Curves.easeInOut], [Curves.fastOutSlowIn],
  /// and [Curves.easeOut].
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve transitionCurve;

  /// Creates a copy of this NavigationTheme with the given fields replaced.
  ///
  /// {@template navigation_theme_copy_with}
  /// Returns a new NavigationTheme where only the specified properties
  /// are changed. All other properties remain identical to the original.
  /// This is useful for creating slight variations of an existing theme.
  /// {@endtemplate}
  ///
  /// ## Example
  /// ```dart
  /// final fasterTheme = originalTheme.copyWith(
  ///   transitionDuration: Duration(milliseconds: 150),
  ///   transitionCurve: Curves.easeOut,
  /// );
  /// ```
  NavigationTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? borderColor,
    Color? shadowColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return NavigationTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  /// Creates a dark theme variant derived from this theme.
  ///
  /// {@template navigation_theme_for_dark_theme}
  /// Returns a new NavigationTheme with colors optimized for dark mode
  /// applications. The animation properties ([transitionDuration] and 
  /// [transitionCurve]) are preserved from the original theme.
  ///
  /// **Dark Theme Color Mapping:**
  /// - [activeColor] becomes `Color(0xFF3B82F6)` (bright blue)
  /// - [inactiveColor] becomes `Color(0xFF9CA3AF)` (light gray)
  /// - [backgroundColor] becomes `Color(0xFF1F2937)` (dark gray)
  /// - [surfaceColor] becomes `Color(0xFF374151)` (medium dark gray)
  /// - [borderColor] becomes `Color(0xFF374151)` (medium dark gray)
  /// - [shadowColor] becomes `Color(0x4D000000)` (black with 30% opacity)
  /// {@endtemplate}
  ///
  /// ## Example
  /// ```dart
  /// void build(BuildContext context) {
  ///   final isDark = Theme.of(context).brightness == Brightness.dark;
  ///   final navTheme = isDark 
  ///       ? defaultLightTheme.forDarkTheme()
  ///       : defaultLightTheme;
  /// }
  /// ```
  NavigationTheme forDarkTheme() {
    return NavigationTheme(
      activeColor: const Color(0xFF3B82F6),
      inactiveColor: const Color(0xFF9CA3AF),
      backgroundColor: const Color(0xFFD1D5DB),
      surfaceColor: const Color(0xFF374151),
      borderColor: const Color(0xFF374151),
      shadowColor: const Color(0x4D000000),
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationTheme &&
          other.activeColor == activeColor &&
          other.inactiveColor == inactiveColor &&
          other.backgroundColor == backgroundColor &&
          other.surfaceColor == surfaceColor &&
          other.borderColor == borderColor &&
          other.shadowColor == shadowColor &&
          other.transitionDuration == transitionDuration &&
          other.transitionCurve == transitionCurve;
  
  @override
  int get hashCode => Object.hash(
        activeColor,
        inactiveColor,
        backgroundColor,
        surfaceColor,
        borderColor,
        shadowColor,
        transitionDuration,
        transitionCurve,
      );
}