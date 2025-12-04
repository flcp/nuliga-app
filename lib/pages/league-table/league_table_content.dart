import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/league-table/team_inspector_league_table.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class LeagueTableContent extends StatelessWidget {
  const LeagueTableContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      Center(child: Text("Keine Teams gefollowed oder ausgewählt."));
    }

    return Expanded(
      child: TeamInspectorLeagueTable(
        teamName: selectedTeam!.name,
        url: selectedTeam.tableUrl,
      ),
    );
  }
}
