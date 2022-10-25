import 'package:flutter/material.dart';

class ScreenTab {
  ScreenTab({
    required this.index,
    required this.name,
    required this.page,
    required this.title,
    // required this.color,
    required this.icon,
  });

  final int index;
  final String name;
  final Widget page;
  final String title;

  // final Color color;
  final String icon;
}
