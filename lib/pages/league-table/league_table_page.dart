import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/league-table/league_table_page_content.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class LeagueTablePage extends StatelessWidget {
  final FollowedClub team;

  const LeagueTablePage({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabelle"),
        actions: [
          ActionBarOpenLinkButton(
            selectedFollowedTeam: team,
            urlAccessor: (i) => i.rankingTableUrl,
          ),
        ],
      ),
      body: LeagueTablePageContent(team: team),
    );
  }
}
