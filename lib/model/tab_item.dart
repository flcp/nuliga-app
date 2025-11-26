import 'package:flutter/material.dart';

class TabItem {
  final Tab button; // Tab-Widget mit Text/Icon etc.
  final Widget view; // Der Inhalt im TabBarView
  final String? key; // Optional: ein Key oder Identifier

  TabItem({required this.button, required this.view, this.key});
}
