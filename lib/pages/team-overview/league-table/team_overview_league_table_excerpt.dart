import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_page.dart';
import 'package:nuliga_app/pages/team-details/league_table_details_page.dart';
import 'package:nuliga_app/pages/team-overview/league-table/team_overview_league_table_short_item.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class TeamOverviewLeagueTableExcerpt extends StatelessWidget {
  final FollowedClub team;

  const TeamOverviewLeagueTableExcerpt({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LeagueTableService.getThreeClosestRankingsToTeam(
        team.rankingTableUrl,
        team,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center();
        }

        final threeClosestRankings = getDataOrEmptyList(snapshot);

        return InkWell(
          onTap: () {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NextMatchesDetailsPage(team: team, startIndex: 1),
              ),
            );
          },
          child: TeamOverviewLeagueTableShortItem(
            threeClosestRankings: threeClosestRankings,
          ),
        );
      },
    );
  }
}
