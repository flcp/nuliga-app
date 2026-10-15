import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/followed-teams/followed_teams_provider.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/matchday_overview.dart';
import 'package:nuliga_app/services/matches/next-matchday/next_matchday_overview_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:provider/provider.dart';

class NextMatchdayOverviewPage extends StatefulWidget {
  const NextMatchdayOverviewPage({super.key});

  @override
  State<NextMatchdayOverviewPage> createState() =>
      _NextMatchdayOverviewPageState();
}

class _NextMatchdayOverviewPageState extends State<NextMatchdayOverviewPage> {
  final NextMatchdayOverviewService _nextMatchdayOverviewService =
      NextMatchdayOverviewService();

  late Future<List<MatchdayOverview>> _matchdaysFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teams = context.watch<FollowedTeamsProvider>().followedTeams;
    _matchdaysFuture = _nextMatchdayOverviewService.loadMatchdays(teams);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MatchdayOverview>>(
      future: _matchdaysFuture,
      builder: (context, snapshot) {
        final matchdays = getDataOrDefault<List<MatchdayOverview>>(
          snapshot,
          [],
        );

        if (matchdays.isEmpty) {
          return const Center(child: NothingToDisplayIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final day in matchdays) ...[Text(day.date.toIso8601String())],
          ],
        );
      },
    );
  }
}
