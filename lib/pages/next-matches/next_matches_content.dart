import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/team_inspector_next_matches.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class NextMatchesContent extends StatelessWidget {
  const NextMatchesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      Center(child: Text("Keine Teams gefollowed oder ausgewählt."));
    }

    return Expanded(
      child: TeamInspectorNextMatches(
        teamName: selectedTeam!.name,
        matchOverviewUrl: selectedTeam.matchesUrl,
      ),
    );
  }
}
