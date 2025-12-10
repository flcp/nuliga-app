import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/league-table/league_table_ranking_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class LeagueTablePageContent extends StatelessWidget {
  const LeagueTablePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      return Center(child: Text("Keine Teams ausgewählt."));
    }

    return Expanded(
      child: LeagueTableRankingList(
        teamName: selectedTeam!.name,
        url: selectedTeam.tableUrl,
      ),
    );
  }
}
