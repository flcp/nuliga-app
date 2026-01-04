import 'package:flutter/material.dart';
import 'package:nuliga_app/mockpage.dart';
import 'package:nuliga_app/mockpage2.dart';
import 'package:nuliga_app/pages/dashboard/dashboard.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const _widgets = [TeamOverviewPage(), Mockpage(), Mockpage2()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgets.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            // TODO: remove
            label: "TODO",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            // TODO: remove
            label: "TODO",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
