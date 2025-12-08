import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/last-matches/last_matches_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class LastMatchesPageContent extends StatelessWidget {
  const LastMatchesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      Center(child: Text("Keine Teams gefollowed oder ausgewählt."));
    }

    return Expanded(
      child: LastMatchesList(
        teamName: selectedTeam!.name,
        matchOverviewUrl: selectedTeam.matchesUrl,
      ),
    );
  }
}
