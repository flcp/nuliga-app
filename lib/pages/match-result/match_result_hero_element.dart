import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/shared/date.dart';

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

    return Column(
      children: [
        Card(
          elevation: 0,
          // TODO: use proper color
          color: Colors.black.withAlpha(75),
          child: Padding(
            padding: const EdgeInsets.all(Constants.smallCardPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Expanded(
                      child: _MatchResultHeroElementTeamName(
                        matchResult.homeTeamName,
                      ),
                    ),
                    Expanded(
                      child: _MatchResultHeroElementTeamName(
                        matchResult.opponentTeamName,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      matchResult.homeTeamMatchesWon.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge!.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 96),
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
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WinLossIndicator(
              size: 12,
              status: matchResult.getMatchStatusForTeam(teamName),
            ),
            SizedBox(width: Constants.iconTextSpacing),
            Text(
              matchResult.getMatchStatusForTeam(teamName).name,
              style: TextStyle(color: infoColor),
            ),
            SizedBox(width: 24),
            Icon(Icons.calendar_today, size: 18.0, color: infoColor),
            SizedBox(width: Constants.iconTextSpacing),
            Text(
              Date.getDateString(matchResult.time),
              style: TextStyle(color: infoColor),
            ),
            SizedBox(width: 16),
            Icon(Icons.access_time, size: 18.0, color: infoColor),
            SizedBox(width: Constants.iconTextSpacing),

            Text(
              "${matchResult.time.hour}:${matchResult.time.minute.toString().padLeft(2, "0")}",
              style: TextStyle(color: infoColor),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class _MatchResultHeroElementTeamName extends StatelessWidget {
  const _MatchResultHeroElementTeamName(this.teamName);

  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(220),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
