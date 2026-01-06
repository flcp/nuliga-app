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
          child: Padding(
            padding: const EdgeInsets.all(Constants.bigCardPadding),
            child: Column(
              children: [
                _MatchResultHeroElementRow(
                  name: matchResult.homeTeamName,
                  score: matchResult.homeTeamMatchesWon,
                  isWinner: matchResult.didHomeTeamWin(),
                ),
                const SizedBox(height: 12),
                Text(
                  "VS",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary.withAlpha(80),
                  ),
                ),
                const SizedBox(height: 12),
                _MatchResultHeroElementRow(
                  name: matchResult.opponentTeamName,
                  score: matchResult.opponentTeamMatchesWon,
                  isWinner: matchResult.didOpponentTeamWin(),
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                ),
                const SizedBox(height: 8),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MatchResultHeroElementRow extends StatelessWidget {
  const _MatchResultHeroElementRow({
    required this.name,
    required this.score,
    required this.isWinner,
  });

  final String name;
  final int score;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: _MatchResultHeroElementText(name, highlighted: isWinner),
              ),
              SizedBox(width: 12),
              if (isWinner) ...[
                Icon(
                  Icons.emoji_events_outlined,
                  color: Colors.amber,
                  size: 24,
                ),
                SizedBox(width: 12),
              ],
            ],
          ),
        ),
        _MatchResultHeroElementText(score.toString(), highlighted: true),
      ],
    );
  }
}

class _MatchResultHeroElementText extends StatelessWidget {
  const _MatchResultHeroElementText(this.teamName, {this.highlighted = false});

  final String teamName;

  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
