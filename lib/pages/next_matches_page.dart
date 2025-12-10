import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_page_content.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class NextMatchesPage extends StatelessWidget {
  const NextMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: das hier in die content page reinreichen?
    final selectedFollowedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    return Scaffold(
      appBar: AppBar(
        title: Text("Nächste Matches"),
        actions: [
          ActionBarOpenLinkButton(
            selectedFollowedTeam: selectedFollowedTeam,
            urlAccessor: (i) => i.matchesUrl,
          ),
        ],
      ),
      body: Column(
        children: [FollowedTeamNavigation(), NextMatchesPageContent()],
      ),
    );
  }
}
