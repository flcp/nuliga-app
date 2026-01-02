import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/dasboard/league-table/short_league_table_item.dart';
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
          return Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(Constants.smallCardPadding),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: Center(child: Text("Loading")),
              ),
            ),
          );
        }

        final closestRankings = getDataOrEmptyList(snapshot);

        return InkWell(
          onTap: () => navigateToTeamDetails(context),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.bigCardPadding,
                vertical: Constants.bigCardPadding / 2,
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
                child: Column(
                  children: closestRankings
                      .map(
                        (teamRanking) => ShortLeagueTableItem(
                          teamRanking: teamRanking,
                          highlighted: team.name == teamRanking.teamName,
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

  void navigateToTeamDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 1),
      ),
    );
  }
}
