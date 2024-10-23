import 'package:flutter/widgets.dart';

class NavigationBarItem {
  const NavigationBarItem({
    required this.icon,
    Widget? activeIcon,
    this.key,
    this.backgroundColor,
    this.label,
    this.tooltip,
  }) : activeIcon = activeIcon ?? icon;

  final Key? key;
  final Widget icon;
  final Widget activeIcon;
  final String? label;
  final Color? backgroundColor;
  final String? tooltip;
}
