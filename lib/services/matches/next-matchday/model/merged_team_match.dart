import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';

class MergedTeamMatch {
  final FutureMatch scheduled;
  final MatchResult? result;
  final FollowedClub team;

  const MergedTeamMatch({
    required this.scheduled,
    required this.result,
    required this.team,
  });
}
