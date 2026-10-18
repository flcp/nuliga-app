import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/pages/team-details/next-matches/next_matches_details_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/matches/next-matches/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_client.dart';

class NextMatchesDetailsList extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const NextMatchesDetailsList({
    super.key,
    required this.teamName,
    required this.matchOverviewUrl,
  });

  @override
  State<NextMatchesDetailsList> createState() => _NextMatchesDetailsListState();
}

class _NextMatchesDetailsListState extends State<NextMatchesDetailsList> {
  final httpClient = HttpClient();
  final nextMatchesService = NextMatchesService();
  late Future<List<FutureMatch>> _nextMatchesFuture;

  @override
  void initState() {
    super.initState();
    _nextMatchesFuture = nextMatchesService.getNextMatchesForTeam(
      widget.matchOverviewUrl,
      widget.teamName,
    );
  }

  Future<void> refresh() {
    httpClient.clearCache();
    setState(() {
      _nextMatchesFuture = nextMatchesService.getNextMatchesForTeam(
        widget.matchOverviewUrl,
        widget.teamName,
      );
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FutureMatch>>(
      future: _nextMatchesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final nextMatches = getDataOrEmptyList(snapshot);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.bigCardPadding),
          child: RefreshIndicator(
            onRefresh: () => refresh(),
            child: ListView(
              children: [
                if (nextMatches.isEmpty) NothingToDisplayIndicator(),
                ...nextMatches.map(
                  (match) => NextMatchesDetailsListItem(
                    match: match,
                    team: widget.teamName,
                    matchOverviewUrl: widget.matchOverviewUrl,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
