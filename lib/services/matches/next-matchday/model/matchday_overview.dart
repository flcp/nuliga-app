import 'package:nuliga_app/services/matches/next-matchday/model/merged_team_match.dart';

class MatchdayOverview {
  final DateTime date;
  final List<MergedTeamMatch> matches;

  const MatchdayOverview({required this.date, required this.matches});
}
