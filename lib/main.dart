import 'package:flutter/material.dart';
import 'package:nuliga_app/nuliga_app.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NuligaApp());
  }
}
