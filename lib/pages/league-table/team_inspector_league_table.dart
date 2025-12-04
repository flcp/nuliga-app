import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import '../../services/league_table_service.dart';

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

        // todo gleiches vorgehen wie im anderen tab
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final teamStandings = snapshot.data ?? [];

        if (teamStandings.isEmpty) {
          return Center(
            child: Text("Nothing to display. Try refreshing or another URL"),
          );
        }

        return ListView(
          children: teamStandings
              .map(
                (teamStanding) => ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text("${teamStanding.rank.toString()}."),
                          Text(teamStanding.teamName),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 24,
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
