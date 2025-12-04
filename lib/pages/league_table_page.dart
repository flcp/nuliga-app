import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/league-table/league_table_page_content.dart';

class LeagueTablePage extends StatelessWidget {
  const LeagueTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabelle")),
      body: Column(
        children: [FollowedTeamNavigation(), LeagueTablePageContent()],
      ),
    );
  }
}
