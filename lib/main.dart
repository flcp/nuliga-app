import 'package:flutter/material.dart';
import 'package:nuliga_app/mockPage.dart';
import 'package:nuliga_app/pages/team-inspection/team_inspector.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NuligaApp());
  }
}

class NuligaApp extends StatefulWidget {
  const NuligaApp({super.key});

  @override
  State<NuligaApp> createState() => _NuligaAppState();
}

class _NuligaAppState extends State<NuligaApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgets = <Widget>[MockPage(), TeamInspector()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgets.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wrong_location),
            label: 'Mock',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
