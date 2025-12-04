import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class NextMatchesPageContent extends StatelessWidget {
  const NextMatchesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      Center(child: Text("Keine Teams gefollowed oder ausgewählt."));
    }

    return Expanded(
      child: NextMatchesList(
        teamName: selectedTeam!.name,
        matchOverviewUrl: selectedTeam.matchesUrl,
      ),
    );
  }
}
