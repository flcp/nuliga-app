import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';

class TeamInspectorNextMatches extends StatelessWidget {
  final String url;
  final String teamName;

  const TeamInspectorNextMatches({
    super.key,
    required this.teamName,
    required this.url,
  });

  String getMatchesOverviewUrl() {
    // todo
    return "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307";
  }

  @override
  Widget build(BuildContext context) {
    final String matchOverviewUrl = getMatchesOverviewUrl();

    return FutureBuilder<List<FutureMatch>>(
      future: NextMatchesService.getNextMatchesForTeam(
        matchOverviewUrl,
        teamName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final nextMatches = snapshot.data ?? [];

        if (nextMatches.isEmpty) {
          return Center(
            child: Text("Could not fetch data from website. Try different URL"),
          );
        }

        return ListView(
          children: nextMatches
              .map(
                (match) => ListTile(
                  leading: SizedBox(
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${match.time.day}.${match.time.month}.${match.time.year}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    match.homeTeam == teamName
                        ? match.opponentTeam
                        : match.homeTeam,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
