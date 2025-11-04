/// Provides a lightweight user representation specifically designed for
/// sidebar footer display with avatar support and action callbacks.
import 'package:flutter/material.dart';

/// Lightweight user model for sidebar footer display.
///
/// {@template sidebar_user}
/// The `SidebarUser` class represents a minimal user identity suitable for
/// displaying in navigation sidebar footers. It supports both text-based
/// avatars (initials) and image avatars, along with optional callbacks
/// for user interactions like profile viewing and logout.
///
/// **Key Features:**
/// - Flexible avatar support (text initials or image)
/// - Automatic initials generation from name
/// - Optional tap callbacks for user actions
/// - Immutable and const-constructible
/// - Lightweight footprint for sidebar usage
/// {@endtemplate}
///
/// ## Usage
///
/// ```dart
/// const user = SidebarUser(
///   name: 'John Doe',
///   email: 'john.doe@example.com',
///   avatarText: 'JD',
///   onProfileTap: () => navigateToProfile(),
///   onLogoutTap: () => performLogout(),
/// );
/// ```
///
/// See also:
/// - [CircleAvatar], for displaying user avatars in Flutter
/// - [ListTile], commonly used to display user info in sidebars
/// - [UserAccountsDrawerHeader], Flutter's built-in drawer user header
class SidebarUser {
  /// Creates a sidebar user with the given identity and optional callbacks.
  ///
  /// {@template sidebar_user_constructor}
  /// Requires [name] and [email] for basic user identity. Avatar can be
  /// provided via [avatarText] (for custom initials) or [avatarImage]
  /// (for image URL). If [avatarText] is not provided, initials will be
  /// automatically generated from the [name].
  /// {@endtemplate}
  ///
  /// [name] - The user's full name for display and initials generation
  /// [email] - The user's email address for display
  /// [avatarText] - Custom text to display in avatar (overrides auto-generated initials)
  /// [avatarImage] - URL or asset path for user avatar image (overrides text avatar)
  /// [onProfileTap] - Callback when user profile area is tapped
  /// [onLogoutTap] - Callback when logout action is triggered
  ///
  /// ## Example
  /// ```dart
  /// const SidebarUser(
  ///   name: 'Alice Smith',
  ///   email: 'alice.smith@company.com',
  ///   avatarImage: 'assets/images/avatar.jpg',
  ///   onProfileTap: () => print('Profile tapped'),
  ///   onLogoutTap: () => print('Logout tapped'),
  /// );
  /// ```
  const SidebarUser({
    required this.name,
    required this.email,
    this.avatarText,
    this.avatarImage,
    this.onProfileTap,
    this.onLogoutTap,
  });

  /// The user's full name for display.
  ///
  /// This is used for:
  /// - Primary display in the sidebar footer
  /// - Automatic initials generation when [avatarText] is not provided
  /// - User identification
  ///
  /// Should typically be the user's first and last name.
  final String name;

  /// The user's email address for display.
  ///
  /// Displayed as secondary text below the name in the sidebar footer.
  /// Used for additional user identification.
  final String email;

  /// Custom text to display in the avatar circle.
  ///
  /// If provided, this text will be used instead of auto-generated initials
  /// from the [name]. Typically 1-2 characters representing user initials.
  ///
  /// If both [avatarText] and [avatarImage] are provided, [avatarImage]
  /// takes precedence.
  final String? avatarText;

  /// URL or asset path for the user's avatar image.
  ///
  /// If provided, this image will be displayed in the avatar circle instead
  /// of any text-based avatar. Supports both network images and local assets.
  ///
  /// Takes precedence over [avatarText] when both are provided.
  final String? avatarImage;

  /// Callback invoked when the user profile area is tapped.
  ///
  /// Typically used to:
  /// - Navigate to user profile page
  /// - Show profile dialog or bottom sheet
  /// - Open account settings
  ///
  /// If null, the profile area may not be tappable or may have no effect.
  final VoidCallback? onProfileTap;

  /// Callback invoked when the logout action is triggered.
  ///
  /// Typically used to:
  /// - Perform logout authentication
  /// - Clear user session data
  /// - Navigate to login screen
  ///
  /// This is usually triggered by a separate logout button rather than
  /// the main user info area.
  final VoidCallback? onLogoutTap;

  /// Gets the avatar text to display, either custom or auto-generated initials.
  ///
  /// {@template sidebar_user_initials}
  /// Returns the text to display in the avatar circle according to this priority:
  /// 1. If [avatarText] is provided, returns [avatarText]
  /// 2. Otherwise, generates initials from the [name]:
  ///    - For names with 2+ words: first letter of first two words (e.g., "John Doe" → "JD")
  ///    - For single-word names: first 2 characters if available, otherwise the name itself
  /// 3. All initials are converted to uppercase
  /// {@endtemplate}
  ///
  /// ## Examples
  /// ```dart
  /// SidebarUser(name: 'John Doe', email: '...').initials; // 'JD'
  /// SidebarUser(name: 'Alice', email: '...').initials; // 'AL'
  /// SidebarUser(name: 'Bob', email: '...', avatarText: 'BC').initials; // 'BC'
  /// ```
  String get initials {
    if (avatarText != null) return avatarText!;
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SidebarUser &&
          other.name == name &&
          other.email == email &&
          other.avatarText == avatarText &&
          other.avatarImage == avatarImage &&
          other.onProfileTap == onProfileTap &&
          other.onLogoutTap == onLogoutTap;
  

  @override
  int get hashCode => Object.hash(
        name,
        email,
        avatarText,
        avatarImage,
        onProfileTap,
        onLogoutTap,
      );
}