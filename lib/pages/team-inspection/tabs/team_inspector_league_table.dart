import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import '../../../services/league_table_service.dart';

class TeamInspectorLeagueTable extends StatelessWidget {
  final String url;
  final String teamName;

  const TeamInspectorLeagueTable({
    required this.url,
    required this.teamName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeagueTeamRanking>>(
      future: LeagueTableService.getLeagueTeamRankings(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final teamStandings = snapshot.data ?? [];

        if (teamStandings.isEmpty) {
          return Center(child: Text("Could not fetch data from website. Try different URL"));
        }

        return ListView(
          children: teamStandings
              .map(
                (teamStanding) => ListTile(
                  leading: Text("${teamStanding.rank.toString()}."),
                  title: Text(teamStanding.teamName),
                  selected: teamStanding.teamName == teamName,
                  trailing: FractionallySizedBox(
                    widthFactor: 0.15,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(teamStanding.leaguePointsWon.toString()),
                        Text(
                          "${teamStanding.wins}.${teamStanding.draws}:${teamStanding.losses}",
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
