import 'package:flutter/material.dart';
import 'package:nuliga_app/mockPage.dart';
import 'package:nuliga_app/pages/league_table.dart';
import 'package:nuliga_app/pages/team-inspection/team_inspector.dart';

class NuligaApp extends StatefulWidget {
  const NuligaApp({super.key});

  @override
  State<NuligaApp> createState() => _NuligaAppState();
}

class _NuligaAppState extends State<NuligaApp> {
  int _selectedIndex = 0;

  static const _widgets = [MockPage(), TeamInspector(), LeagueTable()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wrong_location),
            label: 'Mock',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Tabelle',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
