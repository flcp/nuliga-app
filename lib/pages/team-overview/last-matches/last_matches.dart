import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatches extends StatelessWidget {
  final FollowedClub team;

  const LastMatches({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LastMatchesService.getLastMatchesForTeam(
        team.matchesUrl,
        team.name,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }

        final matchResults = getDataOrEmptyList(
          snapshot,
        ).getRange(0, 3).toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: matchResults
              .map(
                (result) => SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            result.homeTeam,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.right,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            result.homeTeamMatchesWon.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            result.opponentTeamMatchesWon.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            result.opponentTeam,
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
