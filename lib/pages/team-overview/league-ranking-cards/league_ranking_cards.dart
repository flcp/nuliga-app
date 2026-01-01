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
      height: 150,
      child: Flexible(
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

                    return AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            Constants.bigCardPadding,
                            Constants.bigCardPadding,
                            0,
                            Constants.bigCardPadding
                          ),
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
                                      shortRank.leagueName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withAlpha(100),
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          shortRank.rank.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
                                        ),
                                        Text(
                                          " / ${shortRank.totalTeams}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withAlpha(150),
                                              ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      shortRank.teamName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withAlpha(100),
                                          ),
                                      maxLines: 1,
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
      ),
    );
  }
}
