import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';

class LastMatchesCard extends StatelessWidget {
  const LastMatchesCard({
    super.key,
    required this.matchResult,
    required this.homeTeam,
  });

  final MatchResult matchResult;
  final FollowedClub homeTeam;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(Constants.smallCardPadding),
        child: Row(
          children: [
            Expanded(
              child: MatchResultHeroElementTeamName(matchResult.homeTeamName),
            ),
            MatchResultScorePill(
              matchResult: matchResult,
              teamName: homeTeam.name,
            ),
            Expanded(
              child: MatchResultHeroElementTeamName(
                matchResult.opponentTeamName,
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class MatchResultHeroElementTeamName extends StatelessWidget {
  const MatchResultHeroElementTeamName(this.teamName, {super.key});

  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
