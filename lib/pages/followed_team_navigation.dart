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

    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        children: followedTeams.map((team) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(team.name),
              selected: team == selectedFollowedTeam,
              onSelected: (_) {
                context.read<FollowedTeamsProvider>().selectTeam(team);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
