import 'package:flutter/material.dart';
import 'package:nuliga_app/model/club_navigation_item.dart';

class TabItem {
  final Tab button;
  final Widget? Function(ClubNavigationItem) viewBuilder;
  final String? key;

  TabItem({required this.button, required this.viewBuilder, this.key});
}
