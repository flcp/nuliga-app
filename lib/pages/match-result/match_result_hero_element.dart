import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class MatchResultHeroElement extends StatelessWidget {
  const MatchResultHeroElement({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  final MatchResult matchResult;

  final String teamName;

  @override
  Widget build(BuildContext context) {
    final infoColor = Theme.of(context).colorScheme.onSurface.withAlpha(150);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 0,
            // TODO: use proper color
            color: Colors.black.withAlpha(75),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Expanded(
                        child: MatchResultHeroElementTeamName(
                          matchResult.homeTeamName,
                        ),
                      ),
                      Expanded(
                        child: MatchResultHeroElementTeamName(
                          matchResult.opponentTeam,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 64,
                    children: [
                      Text(
                        matchResult.homeTeamMatchesWon.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(color: Colors.white),
                      ),
                      Text(
                        matchResult.opponentTeamMatchesWon.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              WinLossIndicator(
                size: 12,
                status: matchResult.getMatchStatusForTeam(teamName),
              ),
              Text(
                matchResult.getMatchStatusForTeam(teamName).name,
                style: TextStyle(color: infoColor),
              ),
              SizedBox(width: 24),
              Icon(Icons.calendar_today, size: 18.0, color: infoColor),
              Text(
                getDateString(matchResult.time),
                style: TextStyle(color: infoColor),
              ),
              SizedBox(width: 16),
              Icon(Icons.access_time, size: 18.0, color: infoColor),
              Text(
                "${matchResult.time.hour}:${matchResult.time.minute.toString().padLeft(2, "0")}",
                style: TextStyle(color: infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MatchResultHeroElementLocation extends StatelessWidget {
  MatchResultHeroElementLocation({
    super.key,
    required this.location,
    required this.isHome,
  });

  final String location;
  final bool isHome;
  final nextMatchesService = NextMatchesService();

  @override
  Widget build(BuildContext context) {
    if (isHome) {
      return Text("Home");
    }

    if (location.isEmpty) {
      return Text("Unbekannt");
    }

    return FutureBuilder(
      // TODO: move to lastmatchesservice oder so
      future: nextMatchesService.getLocationFromUrl(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }

        final location = getDataOrDefault(snapshot, "Unknown");

        return Text(location);
      },
    );
  }
}

class MatchResultHeroElementTeamName extends StatelessWidget {
  const MatchResultHeroElementTeamName(this.teamName, {super.key});

  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
