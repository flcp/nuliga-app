import 'package:flutter/material.dart';
import 'package:nuliga_app/model/club_navigation_item.dart';
import 'package:nuliga_app/pages/team-inspection/team_inspector_tab_manager.dart';

class TeamInspector extends StatefulWidget {
  const TeamInspector({super.key});

  @override
  State<TeamInspector> createState() => _TeamInspectorState();
}

class _TeamInspectorState extends State<TeamInspector>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ClubNavigationItem> _favoriteClubs = [
    ClubNavigationItem(
      name: "SSC Karlsruhe",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe II",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe III",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe IV",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35328",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35328",
    ),
  ];
  late ClubNavigationItem _selectedClub;

  @override
  void initState() {
    super.initState();
    _selectedClub = _favoriteClubs[0];
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => e.button).toList(),
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              children: _favoriteClubs.map((club) {
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
              }).toList(),
            ),
          ),
          Expanded(
            child: TeamInspectorTabManager(
              tabController: _tabController,
              selectedClub: _selectedClub,
            ),
          ),
        ],
      ),
    );
  }
}
