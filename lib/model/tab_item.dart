import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/team-inspection/team_inspector.dart';

class TabItem {
  final Tab button;
  final Widget? Function(FavoriteClub) viewBuilder;
  final String? key;

  TabItem({required this.button, required this.viewBuilder, this.key});
}
