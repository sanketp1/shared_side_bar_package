import 'package:flutter/material.dart';
import 'package:shared_side_bar_package/shared_side_bar_package.dart';

const List<NavItem> navigationItems = [
  NavItem(
    label: 'Dashboard',
    path: '/dashboard',
    icon: Icons.dashboard_outlined, 
    activeIcon: Icons.dashboard,
  ),
  NavItem(
    label: 'Analytics',
    path: '/analytics',
    icon: Icons.analytics_outlined,
    activeIcon: Icons.analytics,
  ),
  NavItem(
    label: 'Projects',
    path: '/projects',
    icon: Icons.folder_outlined,
    activeIcon: Icons.folder,
    badgeCount: 3,
  ),
];
