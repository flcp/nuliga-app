import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/followed-teams/followed_teams_provider.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/matchday_overview.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/merged_team_match.dart';
import 'package:nuliga_app/services/matches/next-matchday/next_matchday_overview_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:provider/provider.dart';
import 'package:nuliga_app/services/shared/date.dart';

class NextMatchdayOverviewPage extends StatefulWidget {
  const NextMatchdayOverviewPage({super.key});

  @override
  State<NextMatchdayOverviewPage> createState() =>
      _NextMatchdayOverviewPageState();
}

class _NextMatchdayOverviewPageState extends State<NextMatchdayOverviewPage> {
  final NextMatchdayOverviewService _nextMatchdayOverviewService =
      NextMatchdayOverviewService();
  final PageController _pageController = PageController(initialPage: 0);

  late Future<List<MatchdayOverview>> _matchdaysFuture;
  String? _currentTeamsHash;
  int _selectedMatchdayIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teams = context.watch<FollowedTeamsProvider>().followedTeams;
    final newHash = buildHash(teams);

    if (_currentTeamsHash == newHash) {
      return;
    }

    _currentTeamsHash = newHash;
    _selectedMatchdayIndex = 0;
    _matchdaysFuture = _loadMatchdaysAndSelectDefault(teams);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

        final selectedMatchday = matchdays[_selectedMatchdayIndex];
        final date = selectedMatchday.date;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filled(
                    onPressed: _selectedMatchdayIndex > 0
                        ? () => _pageController.animateToPage(
                            _selectedMatchdayIndex - 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          )
                        : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _resetMatchdayToDefault(matchdays),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        context.getDate().getLongDateWithFullMonthWithoutYear(
                          date,
                        ),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: _selectedMatchdayIndex < matchdays.length - 1
                        ? () => _pageController.animateToPage(
                            _selectedMatchdayIndex + 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          )
                        : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const _ThresholdPageScrollPhysics(
                  dragStartDistanceMotionThreshold: 24,
                ),
                itemCount: matchdays.length,
                onPageChanged: (index) {
                  setState(() => _selectedMatchdayIndex = index);
                },
                itemBuilder: (context, index) {
                  final selectedDay = matchdays[index];
                  final matches = selectedDay.matches;

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
              ),
            ),
          ],
        );
      },
    );
  }

  void _resetMatchdayToDefault(List<MatchdayOverview> matchdays) {
    final defaultIndex = _defaultMatchdayIndex(matchdays);
    setState(() => _selectedMatchdayIndex = defaultIndex);

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        defaultIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<List<MatchdayOverview>> _loadMatchdaysAndSelectDefault(
    List<FollowedClub> teams,
  ) async {
    final matchdays = await _nextMatchdayOverviewService.loadMatchdays(teams);

    if (matchdays.isEmpty) {
      return matchdays;
    }

    final defaultMatchdayIndex = _defaultMatchdayIndex(matchdays);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _selectedMatchdayIndex == defaultMatchdayIndex) {
        return;
      }

      setState(() => _selectedMatchdayIndex = defaultMatchdayIndex);

      if (_pageController.hasClients) {
        _pageController.jumpToPage(defaultMatchdayIndex);
      }
    });

    return matchdays;
  }

  int _defaultMatchdayIndex(List<MatchdayOverview> matchdays) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    for (var i = 0; i < matchdays.length; i++) {
      final matchdayDate = DateTime(
        matchdays[i].date.year,
        matchdays[i].date.month,
        matchdays[i].date.day,
      );

      if (matchdayDate == todayDate) {
        return i;
      }
    }

    for (var i = 0; i < matchdays.length; i++) {
      final matchdayDate = DateTime(
        matchdays[i].date.year,
        matchdays[i].date.month,
        matchdays[i].date.day,
      );

      if (matchdayDate.add(const Duration(days: 2)).isAfter(todayDate)) {
        return i;
      }
    }

    return matchdays.length - 1;
  }

  String buildHash(List<FollowedClub> teams) {
    return teams
        .map((team) => '${team.name}|${team.shortName}|${team.matchesUrl}')
        .join(';;');
  }
}

class _ThresholdPageScrollPhysics extends PageScrollPhysics {
  const _ThresholdPageScrollPhysics({
    this.dragStartDistanceMotionThreshold = 24,
    super.parent,
  });

  @override
  final double dragStartDistanceMotionThreshold;

  @override
  _ThresholdPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ThresholdPageScrollPhysics(
      parent: buildParent(ancestor),
      dragStartDistanceMotionThreshold: dragStartDistanceMotionThreshold,
    );
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
          // margin: const EdgeInsets.only(bottom: Constants.bigCardListSpacing),
          child: Padding(
            padding: const EdgeInsets.all(Constants.bigCardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                if (matches.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(localization.nothingToDisplay),
                  )
                else
                  ...matches.map(
                    (match) => InkWell(
                      onTap: () => _goToMatchDetails(context, match),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
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
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _goToMatchDetails(BuildContext context, MergedTeamMatch match) {
    final result = match.result;

    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MatchResultPage(matchResult: result, teamName: team.name),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NextMatchPage(match: match.scheduled, teamName: team.name),
      ),
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
