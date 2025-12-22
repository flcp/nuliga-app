import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/match_result.dart';

class LastMatchesCard extends StatelessWidget {
  const LastMatchesCard({
    super.key,
    required this.matchResult,
    required this.homeTeam,
  });

  final MatchResult matchResult;
  final FollowedClub homeTeam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: getColorDependingOnWinner(
              matchResult,
              homeTeam,
              Theme.of(context).colorScheme,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MatchResultHeroElementTeamName(
                    matchResult.homeTeamName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${matchResult.homeTeamMatchesWon} - ${matchResult.opponentTeamMatchesWon}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MatchResultHeroElementTeamName(
                    matchResult.opponentTeam,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Gradient getColorDependingOnWinner(
    MatchResult matchResult,
    FollowedClub followedTeam,
    ColorScheme colorScheme,
  ) {
    final highlightedGradient = LinearGradient(
      colors: [colorScheme.primary, colorScheme.tertiary],
      stops: [0.4, 1],
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
    );

    final normalGradient = LinearGradient(
      colors: [colorScheme.onPrimaryFixedVariant, colorScheme.onPrimaryFixed],
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
    );

    final isHomeMatch = matchResult.homeTeamName == followedTeam.name;
    final didFavoriteTeamWin = isHomeMatch
        ? matchResult.homeTeamMatchesWon > matchResult.opponentTeamMatchesWon
        : matchResult.opponentTeamMatchesWon > matchResult.homeTeamMatchesWon;

    return didFavoriteTeamWin ? highlightedGradient : normalGradient;
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
