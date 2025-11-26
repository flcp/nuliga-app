import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/team-inspection/tab_manager.dart';

class TeamInspector extends StatefulWidget {
  const TeamInspector({super.key});

  @override
  State<TeamInspector> createState() => _TeamInspectorState();
}

class _TeamInspectorState extends State<TeamInspector>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<FavoriteClub> _favoriteClubs = [
    FavoriteClub(
      name: "SSC Karlsruhe",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
    ),
    FavoriteClub(
      name: "SSC Karlsruhe II",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
    ),
  ];
  late FavoriteClub _selectedClub;

  @override
  void initState() {
    super.initState();
    _selectedClub = _favoriteClubs[0];
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspect team"),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => e.button).toList(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemCount: _favoriteClubs.length,
              itemBuilder: (context, index) {
                final club = _favoriteClubs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(club.name),
                    selected: _selectedClub == club,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedClub = club;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: TabManager(
              tabController: _tabController,
              selectedClub: _selectedClub,
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteClub {
  final String name;
  final String tableUrl;

  FavoriteClub({required this.name, required this.tableUrl});
}
