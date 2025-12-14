import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_list_location_indicator.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_page.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/team-overview/team_overview_list_card.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class NextMatchesOverviewPage extends StatefulWidget {
  const NextMatchesOverviewPage({super.key});

  @override
  State<NextMatchesOverviewPage> createState() =>
      _NextMatchesOverviewPageState();
}

class _NextMatchesOverviewPageState extends State<NextMatchesOverviewPage> {
  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    final teams = provider.followedTeams;

    return Scaffold(
      appBar: AppBar(title: Text("Overview")),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: teams.map((team) {
            return Column(
              children: [
                Text(
                  team.shortName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FutureBuilder(
                  future:
                      NextMatchesService.getNextMatchesWithNextGamedaySeparate(
                        team.matchesUrl,
                        team.name,
                      ),
                  builder: (context, snapshot) {
                    final nextMatches = getDataOrDefault(snapshot, (
                      next: [],
                      later: [],
                    ));

                    final nextTwoMatches = nextMatches.next;
                    final laterMatches = nextMatches.later;

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 155,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...nextTwoMatches.map(
                              (match) => TeamOverviewNextMatchCard(
                                team: team,
                                match: match,
                                highlighted: true,
                              ),
                            ),
                            ...laterMatches.map(
                              (match) => TeamOverviewNextMatchCard(
                                team: team,
                                match: match,
                                highlighted: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TeamOverviewNextMatchCard extends StatelessWidget {
  final FollowedClub team;
  final FutureMatch match;
  final bool highlighted;

  const TeamOverviewNextMatchCard({
    super.key,
    required this.team,
    required this.match,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = highlighted
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).cardColor;

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  getOpponent(match, team),
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.clip,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${match.time.day}.${match.time.month}.${match.time.year}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  NextMatchesDetailsLocationIndicator(
                    match: match,
                    homeTeamName: team.name,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getOpponent(FutureMatch match, FollowedClub team) {
    final isHomeMatch = match.homeTeam == team.name;
    return isHomeMatch ? match.opponentTeam : match.homeTeam;
  }
}
