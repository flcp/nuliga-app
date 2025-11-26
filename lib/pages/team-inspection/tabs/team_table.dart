import 'package:flutter/material.dart';
import 'package:nuliga_app/data-collector/http.dart';
import 'package:nuliga_app/data-collector/league_parser.dart';

class TeamTable extends StatelessWidget {
  final String url;
  final String teamName;

  const TeamTable({required this.url, required this.teamName, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchWebsite(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final html = snapshot.data ?? "";
        final teamStandings = LeagueParser.parse(html);

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
