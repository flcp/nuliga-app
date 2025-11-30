import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';

class TeamInspectorNextMatches extends StatelessWidget {
  final String nextMatchesUrl;
  final String teamName;

  const TeamInspectorNextMatches({
    super.key,
    required this.teamName,
    required this.nextMatchesUrl,
  });

  @override
  Widget build(BuildContext context) {
    final String matchOverviewUrl = nextMatchesUrl;

    return FutureBuilder<List<FutureMatch>>(
      future: NextMatchesService.getNextMatchesForTeam(
        matchOverviewUrl,
        teamName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //todo extract
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          // todo extract
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final nextMatches = snapshot.data ?? [];

        if (nextMatches.isEmpty) {
          // todo extract
          return Center(
            child: Text("Nothing to display. Try refreshing or another URL"),
          );
        }

        return ListView(
          children: nextMatches
              .map(
                (match) => ListTile(
                  selected: isOnNextMatchDay(match, nextMatches),
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

  bool isOnNextMatchDay(FutureMatch match, List<FutureMatch> nextMatches) {
    final nextMatchTime = nextMatches
        .map((m) => m.time)
        .toList()
        .reduce((min, e) => e.isBefore(min) ? e : min);

    return match.time.day == nextMatchTime.day &&
        match.time.month == nextMatchTime.month &&
        match.time.year == nextMatchTime.year;
  }
}
