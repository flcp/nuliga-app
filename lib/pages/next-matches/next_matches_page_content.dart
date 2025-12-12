import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class NextMatchesPageContent extends StatelessWidget {
  const NextMatchesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    final selectedTeam = provider.selectedFollowedTeam;

    if (selectedTeam == null) {
      return Center(child: Text("Kein Team ausgewählt"));
    }

    return Column(
      children: [
        FollowedTeamNavigation(),
        Expanded(
          child: NextMatchesList(
            teamName: selectedTeam.name,
            matchOverviewUrl: selectedTeam.matchesUrl,
          ),
        ),
      ],
    );
  }
}
