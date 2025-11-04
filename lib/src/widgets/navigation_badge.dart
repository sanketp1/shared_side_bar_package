/// Small pill-shaped badge to display a count.
import 'package:flutter/material.dart';

/// Small pill-shaped badge to display notification counts.
///
/// {@template navigation_badge}
/// The `NavigationBadge` widget displays a compact, pill-shaped badge
/// typically used to show notification counts in navigation components.
/// It automatically caps large numbers at "99+" and provides flexible
/// theming options while maintaining consistent visual design.
///
/// **Design Features:**
/// - Pill-shaped container with rounded corners
/// - Automatic number capping (99+ for values > 99)
/// - Optional custom colors for background and text
/// - Minimum size constraints for consistent appearance
/// - Border for better visibility on various backgrounds
/// - Responsive text sizing and centering
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// NavigationBadge(
///   count: 5,
///   backgroundColor: Colors.red,
///   textColor: Colors.white,
/// )
/// ```
///
/// See also:
/// - [Badge], Flutter's built-in badge component
/// - [Chip], for similar pill-shaped design patterns
/// - [Theme.colorScheme], for default color theming
class NavigationBadge extends StatelessWidget {
  /// Creates a pill-shaped badge for displaying counts.
  ///
  /// {@template navigation_badge_constructor}
  /// Requires [count] to be non-null and positive. The badge automatically
  /// formats large numbers as "99+" to maintain compact sizing.
  /// {@endtemplate}
  ///
  /// [key] - Widget key for identification
  /// [count] - The number to display in the badge (capped at 99+)
  /// [backgroundColor] - Optional custom background color
  /// [textColor] - Optional custom text color
  ///
  /// ## Example
  /// ```dart
  /// NavigationBadge(
  ///   key: ValueKey('notification_badge'),
  ///   count: 25,
  ///   backgroundColor: Colors.deepOrange,
  ///   textColor: Colors.white,
  /// )
  /// ```
  const NavigationBadge({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  /// The count to display in the badge.
  ///
  /// Values are automatically formatted:
  /// - 1-99: Displayed as the actual number
  /// - 100+: Displayed as "99+" to maintain compact size
  ///
  /// Typically represents notification counts, unread messages, or
  /// other numerical indicators.
  final int count;

  /// Optional custom background color for the badge.
  ///
  /// If not provided, defaults to [Theme.colorScheme.error] which
  /// typically provides a high-contrast attention-grabbing color.
  final Color? backgroundColor;

  /// Optional custom text color for the count.
  ///
  /// If not provided, defaults to [Theme.colorScheme.onError] which
  /// is designed to provide proper contrast against the background color.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayCount = count > 99 ? '99+' : count.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.error,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.surface,
          width: 2,
        ),
      ),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: Text(
        displayCount,
        style: TextStyle(
          color: textColor ?? theme.colorScheme.onError,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}