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
            matches: mergedTeamMatchesByDate[day]!,
          ),
        )
        .toList();
  }

  Future<List<MergedTeamMatch>> _loadMergedTeamMatches(
    List<FollowedClub> teams,
  ) async {
    final mergedTeamMatches = <MergedTeamMatch>[];

    await Future.wait(
      teams.map((team) async {
        final futureMatchesForTeam =
            (await nextMatchesRepository.getNextMatches(team.matchesUrl)).where(
              (match) =>
                  match.homeTeam == team.name ||
                  match.opponentTeam == team.name,
            );

        final resultsForTeam =
            (await lastMatchesRepository.getLastMatches(team.matchesUrl)).where(
              (result) =>
                  result.homeTeamName == team.name ||
                  result.opponentTeamName == team.name,
            );

        for (final match in futureMatchesForTeam) {
          final key = _matchKey(match.time, match.homeTeam, match.opponentTeam);
          final MatchResult? resultForMatch = resultsForTeam
              .where(
                (r) =>
                    _matchKey(r.time, r.homeTeamName, r.opponentTeamName) ==
                    key,
              )
              .firstOrNull;

          mergedTeamMatches.add(
            MergedTeamMatch(
              scheduled: match,
              result: resultForMatch,
              team: team,
            ),
          );
        }
      }),
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
