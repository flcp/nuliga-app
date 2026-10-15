import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/league-table/model/short_league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/services/league-table/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LeagueInfo extends StatefulWidget {
  const LeagueInfo({super.key, required this.team});

  final FollowedClub team;

  @override
  State<LeagueInfo> createState() => _LeagueInfoState();
}

class _LeagueInfoState extends State<LeagueInfo> {
  late Future<ShortLeagueTeamRanking> _leagueTableFuture;
  final LeagueTableService leagueTableService = LeagueTableService();

  @override
  void initState() {
    super.initState();
    _leagueTableFuture = leagueTableService.getShortRankingForTeam(
      widget.team.rankingTableUrl,
      widget.team.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(150);

    return Padding(
      padding: const EdgeInsets.all(Constants.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.team.name,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ActionBarFollowedTeamOpenLinkButton(
                selectedFollowedTeam: widget.team,
                urlAccessor: (i) => widget.team.rankingTableUrl,
                color: greyedOutColor,
              ),
            ],
          ),
          FutureBuilder(
            future: _leagueTableFuture,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  children: [
                    Expanded(child: SquareSurfaceCard(child: Center())),
                  ],
                );
              }

              final shortRank = getDataOrDefault(
                asyncSnapshot,
                ShortLeagueTeamRanking.empty,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shortRank.leagueName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 125,
                    child: Row(
                      children: [
                        Expanded(
                          child: SquareSurfaceCard(
                            title: localization.rank,
                            onTap: () => navigateToTeamDetails(context),
                            highlighted: true,
                            child: Text(
                              "${shortRank.rank.toString()}.",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: SquareSurfaceCard(
                            title: localization.matchesPlayed,
                            onTap: () => navigateToResults(context),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  shortRank.playedMatches.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "  / ${(shortRank.totalTeams - 1) * 2}",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: greyedOutColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void navigateToTeamDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: widget.team, startIndex: 1),
      ),
    );
  }

  void navigateToResults(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: widget.team, startIndex: 2),
      ),
    );
  }
}
