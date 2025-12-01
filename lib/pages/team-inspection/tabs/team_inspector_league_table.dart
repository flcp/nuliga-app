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
          return Center(
            child: Text("Nothing to display. Try refreshing or another URL"),
          );
        }

        const fontSize = 16.0;

        return ListView(
          children: teamStandings
              .map(
                (teamStanding) => ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    "${teamStanding.rank.toString()}.",
                    style: const TextStyle(fontSize: fontSize),
                  ),
                      Text(
                        teamStanding.teamName,
                        style: const TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                      Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(teamStanding.leaguePointsWon.toString()),
                        Text(
                          "${teamStanding.wins}:${teamStanding.draws}:${teamStanding.losses}",
                        ),
                      ],
                    ),
                    ],
                  ),
                  selected: teamStanding.teamName == teamName,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
