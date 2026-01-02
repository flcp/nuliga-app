import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/short_league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
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
        height: 140,
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
                  SurfaceCard(child: Center()),
                  SurfaceCard(child: Center()),
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
                SurfaceCard(
                  title: shortRank.leagueName,
                  child: Text(
                    "${shortRank.rank.toString()}.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SurfaceCard(
                  title: "Matches gespielt",
                  child: Row(
                    children: [
                      Text(
                        shortRank.played.toString(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "  / ${(shortRank.totalTeams - 1) * 2}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: greyedOutColor),
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
