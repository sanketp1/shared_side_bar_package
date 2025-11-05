# Shared Side Bar Package 🚀

A beautiful, responsive navigation package for Flutter that automatically adapts between sidebar (desktop/tablet) and bottom navigation (mobile) with smooth animations.

![Flutter](https://img.shields.io/badge/Flutter-3.19+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- **Responsive Design** - Automatically switches between sidebar and bottom navigation
- **Smooth Animations** - Beautiful transitions between layout states
- **Customizable Theme** - Consistent theming across all components
- **Badge Support** - Notification badges with count display
- **High Performance** - Optimized with ValueNotifier and efficient rebuilds
- **Accessibility** - Full semantic support and screen reader compatibility

## 🎯 Preview

### Sidebar (Desktop/Tablet)

<video src="https://github.com/user-attachments/assets/b3da7d65-9d39-46aa-b100-4165ee1b2040" controls title="Sidebar preview" width="640">
  Your browser does not support the video tag.
  <a href="https://github.com/user-attachments/assets/b3da7d65-9d39-46aa-b100-4165ee1b2040">View sidebar preview</a>
  
</video>

### Bottom Navigation (Mobile)

<video src=" https://github.com/user-attachments/assets/a41b0253-17ed-435c-926c-d5e2c4625045" controls title="Bottom navigation preview" width="360">
  Your browser does not support the video tag.
  <a href=" https://github.com/user-attachments/assets/a41b0253-17ed-435c-926c-d5e2c4625045">View bottom navigation preview</a>
  
</video>

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  shared_side_bar_package: ^1.0.0
```

## 🚀 Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveSideNavigationBar(
        child: MyHomePage(), // Your main content
        items: [
          NavItem(
            label: 'Home',
            path: '/home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home_filled,
            badgeCount: 3,
          ),
          NavItem(
            label: 'Profile', 
            path: '/profile',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
          // Add more items...
        ],
        selectedIndex: 0,
        onItemTapped: (index, path) {
          // Handle navigation
          print('Navigating to: $path');
        },
        user: SidebarUser(
          name: 'John Doe',
          email: 'john@example.com',
          onProfileTap: () => print('Profile tapped'),
        ),
        appName: 'MyApp',
      ),
    );
  }
}
```

## 🎨 Customization

### Custom Theme

```dart
NavigationTheme(
  activeColor: Colors.deepPurple,
  inactiveColor: Colors.grey,
  backgroundColor: Colors.white,
  transitionDuration: Duration(milliseconds: 500),
)
```

### Custom Header/Footer

```dart
ResponsiveSideNavigationBar(
  // ...
  sidebarHeader: (isExpanded, onToggle) => CustomHeader(),
  sidebarFooter: (isExpanded, user) => CustomFooter(user),
  logo: FlutterLogo(size: 40),
)
```

### Responsive Breakpoint

```dart
ResponsiveSideNavigationBar(
  tabletBreakpoint: 1024, // Custom breakpoint
  // ...
)
```

## 📚 API Reference

### Main Components
- **ResponsiveSideNavigationBar** - Complete responsive navigation shell
- **ModernSidebar** - Collapsible sidebar component
- **CustomBottomNavBar** - Animated bottom navigation
- **NavItem** - Navigation item data model
- **NavigationTheme** - Theming configuration

### Models
- **NavItem** - Navigation items with icons, badges, and paths
- **NavigationTheme** - Colors, animations, and styling
- **SidebarUser** - User info for sidebar footer

### Utilities
- **NavigationUtils** - Responsive helpers and theme adapters

## 🔧 Advanced Usage

### Standalone Sidebar

```dart
ModernSidebar(
  items: navItems,
  selectedIndex: currentIndex,
  onItemTapped: (index, path) => navigate(path),
  user: currentUser,
)
```

### Standalone Bottom Navigation

```dart
CustomBottomNavBar(
  items: navItems,
  selectedIndex: currentIndex,
  onItemTapped: (index, path) => navigate(path),
)
```

## 🤝 Contributing

We welcome contributions! Please feel free to submit issues, feature requests, or pull requests.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

Made by Sanket with ❤️ 🚀
