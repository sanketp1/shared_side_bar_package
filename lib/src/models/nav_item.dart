

///
/// This model represents a single navigation item that can be used across
/// different navigation components in the application. It provides a unified
/// way to define navigation targets with their visual representation and behavior.
import 'package:flutter/material.dart';

/// A route/navigation descriptor for navigation components.
///
/// {@template nav_item}
/// The `NavItem` class encapsulates all properties needed to represent a
/// navigation item in the UI, including its visual presentation, navigation
/// target, and interactive state.
///
/// **Key Features:**
/// - Dual icons for regular and active states
/// - Accessibility support through semantic labels
/// - Badge count display for notifications
/// - Enable/disable state management
/// - Value-based equality and copy functionality
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// const homeItem = NavItem(
///   label: 'Home',
///   path: '/home',
///   icon: Icons.home_outlined,
///   activeIcon: Icons.home_filled,
///   semanticLabel: 'Navigate to home page',
///   badgeCount: 3,
/// );
/// ```
///
/// See also:
/// - [BottomNavigationBar], which can use NavItem for bottom navigation
/// - [NavigationRail], which can use NavItem for sidebar navigation
/// - [Navigator], for managing route navigation
class NavItem {
  /// Creates a navigation item with the given properties.
  ///
  /// {@template nav_item_constructor}
  /// Requires [label], [path], [icon], and [activeIcon] to be non-null.
  /// The [semanticLabel] is optional and will fall back to [label] if not provided.
  /// {@endtemplate}
  ///
  /// ## Example
  /// ```dart
  /// const NavItem(
  ///   label: 'Profile',
  ///   path: '/profile',
  ///   icon: Icons.person_outline,
  ///   activeIcon: Icons.person,
  ///   semanticLabel: 'Navigate to profile page',
  ///   badgeCount: 0,
  ///   enabled: true,
  /// )
  /// ```
  const NavItem({
    required this.label,
    required this.path,
    required this.icon,
    required this.activeIcon,
    this.semanticLabel,
    this.enabled = true,
    this.badgeCount = 0,
  });

  /// The display text for the navigation item.
  ///
  /// This is typically shown next to or below the icon in navigation components.
  final String label;

  /// The route path to navigate to when this item is selected.
  ///
  /// This should match one of the routes defined in your application's router.
  final String path;

  /// The icon to display when this navigation item is not active.
  ///
  /// Typically an outlined version of the icon to indicate inactive state.
  final IconData icon;

  /// The icon to display when this navigation item is active.
  ///
  /// Typically a filled version of the icon to indicate active state.
  /// Should be visually distinct from [icon].
  final IconData activeIcon;

  /// An optional semantic label for accessibility.
  ///
  /// If provided, this will be used by screen readers to describe the
  /// navigation item. If not provided, [label] will be used as fallback.
  final String? semanticLabel;

  /// Whether this navigation item is enabled and can be interacted with.
  ///
  /// Defaults to `true`. When `false`, the item will appear disabled and
  /// will not respond to user interactions.
  final bool enabled;

  /// The number to display as a badge on this navigation item.
  ///
  /// Typically used to show notification counts. A value of `0` means no
  /// badge will be displayed. Defaults to `0`.
  final int badgeCount;

  /// Creates a copy of this NavItem with the given fields replaced.
  ///
  /// {@template nav_item_copy_with}
  /// This method returns a new NavItem where only the specified properties
  /// are changed. All other properties remain the same as the original.
  /// {@endtemplate}
  ///
  /// [label] - The new label text, or null to keep the current one
  /// [path] - The new route path, or null to keep the current one
  /// [icon] - The new inactive icon, or null to keep the current one
  /// [activeIcon] - The new active icon, or null to keep the current one
  /// [semanticLabel] - The new semantic label, or null to keep the current one
  /// [enabled] - The new enabled state, or null to keep the current one
  /// [badgeCount] - The new badge count, or null to keep the current one
  ///
  /// ## Example
  /// ```dart
  /// final updatedItem = originalItem.copyWith(
  ///   badgeCount: 5,
  ///   enabled: false,
  /// );
  /// ```
  NavItem copyWith({
    String? label,
    String? path,
    IconData? icon,
    IconData? activeIcon,
    String? semanticLabel,
    bool? enabled,
    int? badgeCount,
  }) {
    return NavItem(
      label: label ?? this.label,
      path: path ?? this.path,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      enabled: enabled ?? this.enabled,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }

  /// Determines whether this NavItem is equal to [other].
  ///
  /// {@template nav_item_equality}
  /// Two NavItems are considered equal if all their properties are equal.
  /// This includes [label], [path], [icon], [activeIcon], [semanticLabel],
  /// [enabled], and [badgeCount].
  /// {@endtemplate}
  ///
  /// Returns `true` if [other] is a NavItem with identical property values.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavItem &&
        other.label == label &&
        other.path == path &&
        other.icon == icon &&
        other.activeIcon == activeIcon &&
        other.semanticLabel == semanticLabel &&
        other.enabled == enabled &&
        other.badgeCount == badgeCount;
  }

  /// The hash code for this NavItem.
  ///
  /// {@template nav_item_hash_code}
  /// The hash code is computed from all properties of the NavItem to ensure
  /// consistency with the [operator ==] implementation.
  /// {@endtemplate}
  ///
  /// This ensures that NavItems can be properly used in collections like
  /// [Set] and [Map].
  @override
  int get hashCode {
    return Object.hash(
      label,
      path,
      icon,
      activeIcon,
      semanticLabel,
      enabled,
      badgeCount,
    );
  }

  @override
  String toString() {
    return 'NavItem(label: $label, path: $path, enabled: $enabled, badgeCount: $badgeCount)';
  }
}
