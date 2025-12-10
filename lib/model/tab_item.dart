import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';

class TabItem {
  final Tab button;
  final Widget? Function(FollowedClub) viewBuilder;
  final String? key;

  TabItem({required this.button, required this.viewBuilder, this.key});
}
