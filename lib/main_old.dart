import 'package:flutter/material.dart';
import 'package:nuliga_app/data-collector/http.dart';
import 'package:nuliga_app/mockPage.dart';

import 'data-collector/league_parser.dart';

void main() {
  runApp(const MaterialApp(home: ParsedView()));
}

class ParsedView extends StatelessWidget {
  final _bottomIndex = 0;

  const ParsedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: fetchWebsite(
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
        ),
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
      ),
    );
  }
}
