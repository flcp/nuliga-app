import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/team-overview/next_matches_overview_page.dart';

class NuligaApp extends StatefulWidget {
  const NuligaApp({super.key});

  @override
  State<NuligaApp> createState() => _NuligaAppState();
}

class _NuligaAppState extends State<NuligaApp> {
  int _selectedIndex = 0;

  static const _widgets = [NextMatchesOverviewPage(), Placeholder()];

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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: "TODO",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
