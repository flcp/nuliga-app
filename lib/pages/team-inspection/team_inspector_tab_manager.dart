import 'package:flutter/material.dart';
import 'package:nuliga_app/model/club_navigation_item.dart';
import 'package:nuliga_app/model/tab_item.dart';
import 'package:nuliga_app/pages/team-inspection/tabs/team_inspector_league_table.dart';
import 'package:nuliga_app/pages/team-inspection/tabs/team_inspector_next_matches.dart';

final List<TabItem> tabs = [
  TabItem(
    button: Tab(icon: Icon(Icons.format_list_numbered), text: "Tabelle"),
    viewBuilder: (club) =>
        TeamInspectorLeagueTable(url: club.tableUrl, teamName: club.name),
  ),
  TabItem(
    button: Tab(icon: Icon(Icons.event), text: "Nächste"),
    viewBuilder: (club) => TeamInspectorNextMatches(matchOverviewUrl: club.matchesUrl, teamName: club.name),
  ),
  TabItem(
    button: Tab(icon: Icon(Icons.history), text: "Ergebnisse"),
    viewBuilder: (_) => Center(child: Text('ergebnisse Content')),
  ),
];

class TeamInspectorTabManager extends StatelessWidget {
  const TeamInspectorTabManager({
    super.key,
    required TabController tabController,
    required ClubNavigationItem selectedClub,
  }) : _tabController = tabController,
       _selectedClub = selectedClub;

  final ClubNavigationItem _selectedClub;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => e.viewBuilder(_selectedClub) ?? const SizedBox.shrink())
          .toList(),
    );
  }
}
