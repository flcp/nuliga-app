import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class FollowedTeamNavigation extends StatelessWidget {
  const FollowedTeamNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    final followedTeams = provider.followedTeams;
    final selectedFollowedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (followedTeams.isEmpty) {
      return const Center(child: Text('No club followed'));
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
              label: Text(team.shortName),
              selected: team == selectedFollowedTeam,
              onSelected: (_) {
                provider.selectTeam(team);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
