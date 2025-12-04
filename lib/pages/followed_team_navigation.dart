import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class FollowedTeamNavigation extends StatelessWidget {
  const FollowedTeamNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final followedTeams = context.watch<FollowedTeamsProvider>().followedTeams;
    final selectedFollowedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (followedTeams.isEmpty || selectedFollowedTeam == null) {
      return const Center(child: Text('No club selected'));
    }

    return Text(selectedFollowedTeam.name);
  }
}
