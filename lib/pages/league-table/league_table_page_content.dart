import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/league-table/league_table_ranking_list.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class LeagueTablePageContent extends StatelessWidget {
  final FollowedClub team;

  const LeagueTablePageContent({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tabelle"),
          actions: [
            ActionBarOpenLinkButton(
              selectedFollowedTeam: team,
              urlAccessor: (i) => i.rankingTableUrl,
            ),
          ],
        ),
        body: LeagueTableRankingList(
          teamName: team.name,
          url: team.rankingTableUrl,
        ),
      ),
    );
  }
}
