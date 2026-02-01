import 'package:flutter/material.dart';
import 'package:nuliga_app/services/match-result/model/game_type.dart';

class GameTypeIcon extends StatelessWidget {
  final GameType gameType;

  const GameTypeIcon(this.gameType, {super.key});

  @override
  Widget build(BuildContext context) {
    final icons = switch (gameType) {
      GameType.md1 || GameType.md2 => [Icons.man, Icons.man],
      GameType.wd => [Icons.woman, Icons.woman],
      GameType.xd => [Icons.man, Icons.woman],
      GameType.ms1 || GameType.ms2 || GameType.ms3 => [Icons.man],
      GameType.ws => [Icons.woman],
    };

    return SizedBox(
      width: 28,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          if (icons.length > 1) ...[
            Positioned.directional(
              start: 6,
              textDirection: TextDirection.ltr,
              child: Icon(
                icons.last,
                size: 22,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
              ),
            ),
            Positioned.directional(
              start: 2,
              textDirection: TextDirection.ltr,
              top: 2,
              child: Icon(
                icons.first,
                size: 22,
                // color: Colors.red,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
            ),
            Positioned.directional(
              start: 2,
              textDirection: TextDirection.ltr,

              child: Icon(
                icons.first,
                size: 22,
                // color: Colors.red,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
            ),
          ],
          Icon(
            icons.first,
            size: 22,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
          ),
        ],
      ),
    );
  }
}
