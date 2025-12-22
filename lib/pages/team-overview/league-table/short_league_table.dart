import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/team-overview/league-table/short_league_table_item.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ShortLeagueTable extends StatelessWidget {
  final FollowedClub team;
  final leagueTableService = LeagueTableService();

  ShortLeagueTable({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: leagueTableService.getClosestRankingsToTeam(
        team.rankingTableUrl,
        team,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO: Fix
          return Card(child: Text("loading"));
        }

        final closestRankings = getDataOrEmptyList(snapshot);

        return InkWell(
          onTap: () {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TeamDetailsPage(team: team, startIndex: 1),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24), // Rounded edges
            ),
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onPrimaryFixedVariant,
                    Theme.of(context).colorScheme.onPrimaryFixed,
                  ],

                  // stops: [0.4, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.05, 0.2, 0.8, 0.95],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: closestRankings
                          .map(
                            (teamRanking) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: ShortLeagueTableItem(
                                teamRanking: teamRanking,
                                highlighted: team.name == teamRanking.teamName,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
