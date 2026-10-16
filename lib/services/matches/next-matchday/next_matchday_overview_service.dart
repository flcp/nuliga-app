import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/services/matches/last-matches/repository/last_matches_repository.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/matchday_overview.dart';
import 'package:nuliga_app/services/matches/next-matchday/model/merged_team_match.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/services/matches/next-matches/repository/next_matches_repository.dart';

class NextMatchdayOverviewService {
  final NextMatchesRepository nextMatchesRepository = NextMatchesRepository();
  final LastMatchesRepository lastMatchesRepository = LastMatchesRepository();

  NextMatchdayOverviewService();

  Future<List<MatchdayOverview>> loadMatchdays(List<FollowedClub> teams) async {
    if (teams.isEmpty) {
      return [];
    }

    final mergedTeamMatches = await _loadMergedTeamMatches(teams);
    final mergedTeamMatchesByDate = groupByDate(mergedTeamMatches);

    final sortedDays = mergedTeamMatchesByDate.keys.toList()..sort();
    return sortedDays
        .map(
          (day) => MatchdayOverview(
            date: day,
            matches: [
              ...mergedTeamMatchesByDate[day]!..sort(
                (left, right) => left.scheduled.time.compareTo(
                  right.scheduled.time,
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  Future<List<MergedTeamMatch>> _loadMergedTeamMatches(
    List<FollowedClub> teams,
  ) async {
    final mergedTeamMatchesByTeam = await Future.wait(
      teams.map((team) async {
        final futureMatchesForTeam = (await nextMatchesRepository
            .getNextMatches(team.matchesUrl))
            .where(
              (match) =>
                  match.homeTeam == team.name ||
                  match.opponentTeam == team.name,
            )
            .toList();

        final resultsForTeam = (await lastMatchesRepository.getLastMatches(
          team.matchesUrl,
        ))
            .where(
              (result) =>
                  result.homeTeamName == team.name ||
                  result.opponentTeamName == team.name,
            )
            .toList();

        final matchesByKey = <String, _MergedMatchAggregation>{};

        for (final match in futureMatchesForTeam) {
          final key = _matchKey(match.time, match.homeTeam, match.opponentTeam);
          matchesByKey.putIfAbsent(
            key,
            () => _MergedMatchAggregation(team: team),
          ).scheduled = match;
        }

        for (final result in resultsForTeam) {
          final key = _matchKey(
            result.time,
            result.homeTeamName,
            result.opponentTeamName,
          );
          final aggregation = matchesByKey.putIfAbsent(
            key,
            () => _MergedMatchAggregation(team: team),
          );
          aggregation.result = result;
          aggregation.scheduled ??= FutureMatch(
            time: result.time,
            homeTeam: result.homeTeamName,
            opponentTeam: result.opponentTeamName,
            locationUrl: result.location,
          );
        }

        return matchesByKey.values
            .map((aggregation) => aggregation.toMergedMatch())
            .toList();
      }),
    );

    final mergedTeamMatches = mergedTeamMatchesByTeam.expand((matches) => matches).toList();
    mergedTeamMatches.sort(
      (left, right) => left.scheduled.time.compareTo(right.scheduled.time),
    );

    return mergedTeamMatches;
  }

  String _matchKey(DateTime matchTime, String homeTeam, String opponentTeam) {
    final date = DateTime(matchTime.year, matchTime.month, matchTime.day);
    return '${date.toIso8601String()}|$homeTeam|$opponentTeam';
  }

  Map<DateTime, List<MergedTeamMatch>> groupByDate(
    List<MergedTeamMatch> mergedTeamMatches,
  ) {
    final result = <DateTime, List<MergedTeamMatch>>{};
    for (final match in mergedTeamMatches) {
      final day = DateTime(
        match.scheduled.time.year,
        match.scheduled.time.month,
        match.scheduled.time.day,
      );
      result.putIfAbsent(day, () => []).add(match);
    }
    return result;
  }
}

class _MergedMatchAggregation {
  final FollowedClub team;
  FutureMatch? scheduled;
  MatchResult? result;

  _MergedMatchAggregation({required this.team});

  MergedTeamMatch toMergedMatch() {
    return MergedTeamMatch(
      scheduled: scheduled!,
      result: result,
      team: team,
    );
  }
}
