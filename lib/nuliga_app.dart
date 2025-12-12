import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/last-matches/last_matches_page.dart';
import 'package:nuliga_app/pages/league-table/league_table_page.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_summary_page.dart';

class NuligaApp extends StatefulWidget {
  const NuligaApp({super.key});

  @override
  State<NuligaApp> createState() => _NuligaAppState();
}

class _NuligaAppState extends State<NuligaApp> {
  int _selectedIndex = 0;

  static const _widgets = [
    NextMatchesSummaryPage(),
    LeagueTablePage(),
    LastMatchesPage(),
  ];

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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Nächste"),

          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: "Tabelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Ergebnisse",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
