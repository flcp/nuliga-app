import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches_card.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/services/matches/next_matches_service.dart';
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

    return SizedBox(
      height: 180,
      child: FutureBuilder(
        future: _nextMatchesFuture,
        builder: (context, snapshot) {
          final nextMatches = getDataOrDefault(snapshot, (next: [], later: []));

          if (nextMatches.next.isEmpty && nextMatches.later.isEmpty) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Constants.bigCardPadding,
              ),
              scrollDirection: Axis.horizontal,
              children: [
                SquareSurfaceCard(
                  title: localization.noUpcomingMatches,
                  child: Expanded(
                    child: Center(
                      child: Icon(
                        Icons.search_off,
                        size: 40,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          final nextTwoMatches = nextMatches.next;
          final laterMatches = nextMatches.later;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: Constants.bigCardPadding),

            scrollDirection: Axis.horizontal,
            children: [
              ...nextTwoMatches.map(
                (match) => NextMatchesCard(
                  team: widget.team,
                  match: match,
                  highlighted: true,
                ),
              ),
              ...laterMatches.map(
                (match) => NextMatchesCard(
                  team: widget.team,
                  match: match,
                  highlighted: false,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
