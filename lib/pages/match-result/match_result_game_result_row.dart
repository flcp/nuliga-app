import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/player.dart';

class MatchResultGameResultRow extends StatefulWidget {
  const MatchResultGameResultRow({super.key, required this.gameResult});

  final GameResult gameResult;

  @override
  State<MatchResultGameResultRow> createState() =>
      _MatchResultGameResultRowState();
}

class _MatchResultGameResultRowState extends State<MatchResultGameResultRow> {
  final _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 0,
        child: ExpansionTile(
          controller: _controller,
          showTrailingIcon: false,
          shape: const Border(),
          childrenPadding: EdgeInsets.symmetric(horizontal: 8),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.gameResult.gameType.displayName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PlayersText(
                      players: widget.gameResult.homePlayers,
                      gameType: widget.gameResult.gameType,
                      didPlayersWin: widget.gameResult.homeTeamWon,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.gameResult.homeSetsWon} - ${widget.gameResult.opponentSetsWon}",
                    ),
                  ),

                  Expanded(
                    child: PlayersText(
                      align: TextAlign.right,
                      players: widget.gameResult.opponentPlayers,
                      gameType: widget.gameResult.gameType,
                      didPlayersWin: !widget.gameResult.homeTeamWon,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            GestureDetector(
              onTap: () => _controller.collapse(),
              child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.gameResult.sets
                      .map(
                        (set) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            "${set.homeScore.toString()} - ${set.opponentScore.toString()}",
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayersText extends StatelessWidget {
  final List<Player> players;
  final GameType gameType;
  final bool didPlayersWin;
  final TextAlign align;

  const PlayersText({
    super.key,
    required this.players,
    required this.gameType,
    required this.didPlayersWin,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onSurface.withAlpha(120);
    final textColor = Theme.of(context).colorScheme.onSurface;

    return gameType.isDoubles()
        ? Text(
            players.map((player) => player.lastName).join(" / "),
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: didPlayersWin ? textColor : greyedOutColor,
              fontWeight: didPlayersWin ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          )
        : Text(
            players.first.getFullname(),
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: didPlayersWin ? textColor : greyedOutColor,
              fontWeight: didPlayersWin ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          );
  }
}
