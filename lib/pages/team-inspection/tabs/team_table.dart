import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

import '../../../services/league_table_service.dart';

class TeamTable extends StatelessWidget {
  final String url;
  final String teamName;

  const TeamTable({required this.url, required this.teamName, super.key});

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

        return ListView.builder(
          itemCount: teamStandings.length,
          itemBuilder: (context, i) {
            final teamStanding = teamStandings[i];

            return ListTile(
              title: Text(teamStanding.teamName),
              trailing: FractionallySizedBox(
                widthFactor: 0.2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(teamStanding.leaguePointsWon.toString()),
                    Text(
                      "${teamStanding.wins}:${teamStanding.draws}:${teamStanding.losses}",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
