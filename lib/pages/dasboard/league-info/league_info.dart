import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/short_league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LeagueInfo extends StatelessWidget {
  LeagueInfo({super.key, required this.team});

  final LeagueTableService leagueTableService = LeagueTableService();
  final FollowedClub team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.pagePadding),
      child: SizedBox(
        height: 150,
        child: FutureBuilder(
          future: leagueTableService.getShortRankingForTeam(
            team.rankingTableUrl,
            team.name,
          ),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  LeagueInfoCard(child: Center()),
                  LeagueInfoCard(child: Center()),
                ],
              );
            }

            final shortRank = getDataOrDefault(
              asyncSnapshot,
              ShortLeagueTeamRanking.empty,
            );
            final greyedOutColor = Theme.of(
              context,
            ).colorScheme.onPrimaryContainer.withAlpha(120);

            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                LeagueInfoCard(
                  title: shortRank.leagueName,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Baseline(
                        baseline: 30,
                        baselineType: TextBaseline.alphabetic,

                        child: Text(
                          shortRank.rank.toString(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Baseline(
                        baseline: 30,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "  / ${shortRank.totalTeams}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: greyedOutColor),
                        ),
                      ),
                    ],
                  ),
                ),
                LeagueInfoCard(
                  title: "Matches played",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Row(
                        children: [
                          Baseline(
                            baseline: 30,
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              shortRank.played.toString(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Baseline(
                            baseline: 30,
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              "  / ${(shortRank.totalTeams - 1) * 2}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: greyedOutColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LeagueInfoCard extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  const LeagueInfoCard({
    super.key,
    required this.child,
    this.title = "",
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final chevronColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(50);

    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(120);

    return Padding(
      padding: const EdgeInsets.only(right: Constants.bigCardListSpacing),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Constants.bigCardPadding,
              Constants.bigCardPadding,
              2,
              Constants.bigCardPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: greyedOutColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      child,
                      if (subtitle.isNotEmpty) ...[
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: greyedOutColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: chevronColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
