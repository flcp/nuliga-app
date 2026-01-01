import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/model/short_league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LeagueRankingCards extends StatelessWidget {
  LeagueRankingCards({super.key, required this.teams});

  final LeagueTableService leagueTableService = LeagueTableService();
  final List<FollowedClub> teams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: teams
            .map(
              (team) => FutureBuilder(
                future: leagueTableService.getShortRankingForTeam(
                  team.rankingTableUrl,
                  team.name,
                ),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Card(elevation: 0),
                    );
                  }

                  final shortRank = getDataOrDefault(
                    asyncSnapshot,
                    ShortLeagueTeamRanking.empty,
                  );
                  final leagueType = shortRank.leagueName.split(' ').first;

                  var greyedOutColor = Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha(90);
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    leagueType,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: greyedOutColor),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Baseline(
                                        baseline: 30,
                                        baselineType: TextBaseline.alphabetic,

                                        child: Text(
                                          shortRank.rank.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
                                        ),
                                      ),
                                      Baseline(
                                        baseline: 30,
                                        baselineType: TextBaseline.alphabetic,

                                        child: Text(
                                          "  / ${shortRank.totalTeams}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: greyedOutColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    shortRank.teamName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
