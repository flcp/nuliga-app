import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/team-details/last-matches/last_matches_details_list.dart';

class TeamDetailsLeagueTeamInspector extends StatelessWidget {
  final String teamName;
  final String matchOverviewUrl;

  const TeamDetailsLeagueTeamInspector({
    super.key,
    required this.teamName,
    required this.matchOverviewUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(teamName)),
      body: LastMatchesDetailsList(
        teamName: teamName,
        matchOverviewUrl: matchOverviewUrl,
      ),
    );
  }
}
