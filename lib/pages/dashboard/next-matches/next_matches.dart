import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches_location_indicator.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/services/matches/next-matches/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class NextMatches extends StatefulWidget {
  final String matchesUrl;
  final FollowedClub team;

  const NextMatches({super.key, required this.matchesUrl, required this.team});

  @override
  State<NextMatches> createState() => _NextMatchesState();
}

class _NextMatchesState extends State<NextMatches> {
  late Future<({List<FutureMatch> next, List<FutureMatch> later})>
  _nextMatchesFuture;
  final nextMatchesService = NextMatchesService();

  @override
  void initState() {
    super.initState();
    _nextMatchesFuture = nextMatchesService
        .getNextMatchesWithNextGamedaySeparate(
          widget.matchesUrl,
          widget.team.name,
        );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: _nextMatchesFuture,
      builder: (context, snapshot) {
        final nextMatches = getDataOrDefault(snapshot, (
          next: <FutureMatch>[],
          later: <FutureMatch>[],
        ));

        if (nextMatches.next.isEmpty) {
          // TODO: adjust to below
          return SizedBox();
        }

        final nextTwoMatches = nextMatches.next;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.next,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => goToNextMatches(widget.team),
                    child: Text(localization.viewAll_button),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    context.getDate().getLongDateStringWithoutYear(
                      nextTwoMatches.first.time,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text("·"),
                  Text(
                    nextTwoMatches.first.isHomeTeam(widget.team.name)
                        ? localization.homeGame_short
                        : localization.awayGame_short,
                  ),
                ],
              ),
              SizedBox(height: 8),
              SurfaceCard(
                child: Padding(
                  padding: EdgeInsets.all(Constants.bigCardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      ...nextTwoMatches.map(
                        (match) => InkWell(
                          onTap: () => goToMatch(match, widget.team.name),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  Text(
                                    match.getOpponent(widget.team.name),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              NextMatchesLocationIndicatorButton(
                                match: match,
                                homeTeamName: widget.team.name,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void goToNextMatches(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(team: team)),
    );
  }

  void goToMatch(FutureMatch match, String teamName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextMatchPage(match: match, teamName: teamName),
      ),
    );
  }
}
