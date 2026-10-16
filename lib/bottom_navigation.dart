import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/dashboard/dashboard.dart';
import 'package:nuliga_app/pages/next-matchday/next_matchday_overview_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // final List<Widget> _pages = [TeamOverviewPage()];
  final List<Widget> _pages = [TeamOverviewPage(), NextMatchdayOverviewPage()];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: localizations.matchday,
          ),
        ],
      ),
    );
  }
}
