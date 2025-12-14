import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/team-overview/league-table/team_overview_league_table_excerpt_item.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class TeamOverviewLeagueTableExcerpt extends StatelessWidget {
  final FollowedClub team;

  const TeamOverviewLeagueTableExcerpt({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LeagueTableService.getClosestRankingsToTeam(
        team.rankingTableUrl,
        team,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
            elevation: 0,
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
                  stops: [0.05, 0.25, 0.75, 0.95],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: closestRankings
                      .map(
                        (teamRanking) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TeamOverviewLeagueTableExcerptItem(
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
        );
      },
    );
  }
}
