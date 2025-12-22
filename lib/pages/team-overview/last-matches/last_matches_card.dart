import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';

class LastMatchesCard extends StatelessWidget {
  const LastMatchesCard({super.key, required this.matchResult});

  final MatchResult matchResult;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.tertiary],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MatchResultHeroElementTeamName(matchResult.homeTeam),
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
