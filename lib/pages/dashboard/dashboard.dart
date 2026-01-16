import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/dashboard/dashboard_header_navigation.dart';
import 'package:nuliga_app/pages/dashboard/dashboard_section.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/dashboard/last-matches/last_matches.dart';
import 'package:nuliga_app/pages/dashboard/league-info/league_info.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/shared/http_client.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TeamOverviewPage extends StatefulWidget {
  const TeamOverviewPage({super.key});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  HttpClient httpClient = HttpClient();

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  Future<void> refresh() {
    httpClient.clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();
    final teams = provider.followedTeams;

    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: DashboardHeaderNavigation(
              teams: teams,
              itemPositionsListener: _itemPositionsListener,
              itemScrollController: _itemScrollController,
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              addAutomaticKeepAlives: true,
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Constants.pagePadding),
                      child: Text(
                        team.name,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    LeagueInfo(team: team),
                    SizedBox(height: 16),
                    DashboardSection(
                      isContentWidthConstrained: false,
                      title: "NEXT",
                      onViewAll: () => goToNextMatches(team),
                      child: NextMatches(
                        matchesUrl: team.matchesUrl,
                        team: team,
                      ),
                    ),
                    SizedBox(height: 16),
                    DashboardSection(
                      title: "LAST",
                      child: LastMatches(team: team),
                      onViewAll: () => goToResults(team),
                    ),
                    SizedBox(height: 48),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void goToNextMatches(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(team: team)),
    );
  }

  void goToResults(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 2),
      ),
    );
  }
}
