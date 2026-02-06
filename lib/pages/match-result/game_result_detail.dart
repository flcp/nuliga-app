import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/match-result/model/game_result.dart';
import 'package:nuliga_app/services/match-result/model/game_type.dart';
import 'package:nuliga_app/services/match-result/model/set_result.dart';
import 'package:nuliga_app/pages/match-result/game_type_icon.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';

class GameResultDetail extends StatelessWidget {
  const GameResultDetail({
    super.key,
    required this.gameResult,
    required this.homeTeamName,
    required this.opponentTeamName,
  });

  final GameResult gameResult;
  final String homeTeamName;
  final String opponentTeamName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(Constants.pagePadding),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                GameTypeIcon(gameResult.gameType),
                Text(
                  gameResult.gameType.localize(l10n),
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
            SurfaceCard(
              padding: const EdgeInsets.all(Constants.bigCardPadding),
              title: homeTeamName,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: gameResult.homePlayers
                    .map((player) => Text(player.getFullname()))
                    .toList(),
              ),
            ),
            SurfaceCard(
              padding: const EdgeInsets.all(Constants.bigCardPadding),
              title: l10n.resultCount(2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: gameResult.sets.asMap().entries.map((entry) {
                  final setNumber = entry.key + 1;
                  final set = entry.value;
                  return _SetCard(set, setNumber);
                }).toList(),
              ),
            ),
            SurfaceCard(
              padding: const EdgeInsets.all(Constants.bigCardPadding),
              title: opponentTeamName,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: gameResult.opponentPlayers
                    .map((player) => Text(player.getFullname()))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetCard extends StatelessWidget {
  final SetResult set;
  final int setNumber;

  const _SetCard(this.set, this.setNumber);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            l10n.set(setNumber.toString()),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(180),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text(
                set.homeScore.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: set.homeScore > set.opponentScore
                      ? Color.fromARGB(255, 140, 227, 145)
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),

          Row(
            children: [
              Text(
                set.opponentScore.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: set.opponentScore > set.homeScore
                      ? Color.fromARGB(255, 140, 227, 145)
                      : Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
