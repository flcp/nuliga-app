import 'package:flutter/material.dart';
import 'package:nuliga_app/model/tab_item.dart';
import 'package:nuliga_app/pages/team-inspection/tabs/team_table.dart';
import 'package:nuliga_app/pages/team-inspection/team_inspector.dart';

final List<TabItem> tabs = [
  TabItem(
    button: Tab(icon: Icon(Icons.format_list_numbered), text: "Tabelle"),
    view: TeamTable(
      url:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
      teamName: "SSC Karlsruhe",
    ),
  ),
  TabItem(
    button: Tab(icon: Icon(Icons.event), text: "Nächste"),
    view: Center(child: Text('Profile Content')),
  ),
  TabItem(
    button: Tab(icon: Icon(Icons.history), text: "Letzte"),
    view: Center(child: Text('Settings Content')),
  ),
];

class TabManager extends StatelessWidget {
  const TabManager({
    super.key,
    required TabController tabController,
    required FavoriteClub selectedClub,
  }) : _tabController = tabController,
       _selectedClub = selectedClub;

  final FavoriteClub _selectedClub;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: tabs.map((e) => e.view).toList(),
    );
  }
}
