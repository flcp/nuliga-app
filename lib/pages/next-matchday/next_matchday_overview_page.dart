import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/followed-teams/followed_teams_provider.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/matchday_overview.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/merged_team_match.dart';
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
  String? _currentTeamsHash;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teams = context.watch<FollowedTeamsProvider>().followedTeams;
    final newHash = buildHash(teams);

    if (_currentTeamsHash == newHash) {
      return;
    }

    _currentTeamsHash = newHash;
    _matchdaysFuture = _nextMatchdayOverviewService.loadMatchdays(teams);
  }

  @override
  Widget build(BuildContext context) {
    final teams = context.watch<FollowedTeamsProvider>().followedTeams;

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

        final selectedDay = matchdays.first;

        var matches = selectedDay.matches;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final team in teams)
              _TeamMatchCard(
                team: team,
                matches: matches
                    .where((match) => match.team.name == team.name)
                    .toList(),
              ),
          ],
        );
      },
    );
  }

  String buildHash(List<FollowedClub> teams) {
    return teams
        .map((team) => '${team.name}|${team.shortName}|${team.matchesUrl}')
        .join(';;');
  }
}

class _TeamMatchCard extends StatelessWidget {
  const _TeamMatchCard({required this.team, required this.matches});

  final FollowedClub team;
  final List<MergedTeamMatch> matches;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            team.shortName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Card(
          margin: const EdgeInsets.only(bottom: Constants.bigCardListSpacing),
          child: Padding(
            padding: const EdgeInsets.all(Constants.bigCardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (matches.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(localization.nothingToDisplay),
                  )
                else
                  ...matches.map(
                    (match) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildTeamName(
                              context,
                              name: match.scheduled.homeTeam,
                              isFollowedTeam:
                                  match.scheduled.homeTeam == team.name,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildMatchState(context, match),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTeamName(
                              context,
                              name: match.scheduled.opponentTeam,
                              isFollowedTeam:
                                  match.scheduled.opponentTeam == team.name,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTeamName(
    BuildContext context, {
    required String name,
    required bool isFollowedTeam,
    required TextAlign textAlign,
  }) {
    final theme = Theme.of(context);

    return Text(
      name,
      textAlign: textAlign,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: isFollowedTeam
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
        fontWeight: isFollowedTeam ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildMatchState(BuildContext context, MergedTeamMatch match) {
    final theme = Theme.of(context);
    final result = match.result;

    if (result != null) {
      final score =
          '${result.homeTeamMatchesWon}:${result.opponentTeamMatchesWon}';
      return Text(
        score,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      );
    }

    final time = match.scheduled.time.toLocal();
    final formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Text(
      formattedTime,
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
