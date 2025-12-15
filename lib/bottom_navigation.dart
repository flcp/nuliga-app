import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuliga_app/pages/team-overview/team_overview_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const _widgets = [TeamOverviewPage(), Mockpage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
        ),
      ),
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

class Mockpage extends StatelessWidget {
  const Mockpage({super.key});

  @override
  Widget build(BuildContext context) {
    final maxHeight = 80.0;
    final teamA = "LAAAAAAAAAAAAAANGER NAME";
    final teamB = "kurzer Name";
    final scoreA = 8;
    final scoreB = 0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        children: [
          // First row: Teams
          Row(
            children: [
              // Team A
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    teamA,
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
              ),
              // Center dash
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('-'),
              ),
              // Team B
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(teamB, textAlign: TextAlign.left, softWrap: true),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          // Second row: Scores
          Row(
            children: [
              // Score A
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('$scoreA', textAlign: TextAlign.right),
                ),
              ),
              // Spacer under dash
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(width: 0),
              ),
              // Score B
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('$scoreB', textAlign: TextAlign.left),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
