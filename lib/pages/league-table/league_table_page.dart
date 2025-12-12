import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/league-table/league_table_page_content.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class LeagueTablePage extends StatelessWidget {
  const LeagueTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFollowedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tabelle"),
        actions: [
          ActionBarOpenLinkButton(
            selectedFollowedTeam: selectedFollowedTeam,
            urlAccessor: (i) => i.tableUrl,
          ),
        ],
      ),
      body: Column(
        children: [FollowedTeamNavigation(), LeagueTablePageContent()],
      ),
    );
  }
}
