import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/league-table/model/short_league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/services/league-table/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LeagueInfo extends StatelessWidget {
  LeagueInfo({super.key, required this.team});

  final LeagueTableService leagueTableService = LeagueTableService();
  final FollowedClub team;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

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
                  SquareSurfaceCard(child: Center()),
                  SquareSurfaceCard(child: Center()),
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
                SquareSurfaceCard(
                  title: shortRank.leagueName,
                  onTap: () => navigateToTeamDetails(context),
                  highlighted: true,
                  child: Text(
                    "${shortRank.rank.toString()}.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SquareSurfaceCard(
                  title: localization.matchesPlayed,
                  onTap: () => navigateToResults(context),
                  child: Row(
                    children: [
                      Text(
                        shortRank.playedMatches.toString(),
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

  void navigateToTeamDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 1),
      ),
    );
  }

  void navigateToResults(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 2),
      ),
    );
  }
}
