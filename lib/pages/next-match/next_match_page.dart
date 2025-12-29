import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-match/next_match_countdown.dart';
import 'package:nuliga_app/pages/next-match/next_match_info.dart';
import 'package:nuliga_app/pages/next-match/next_match_matchup.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/next_matches_service.dart';

class NextMatchPage extends StatelessWidget {
  final FutureMatch match;

  final nextMatchesService = NextMatchesService();

  NextMatchPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next match")),
      body: Padding(
        padding: const EdgeInsets.all(Constants.pagePadding),
        child: Column(
          children: [
            NextMatchCountdown(),
            NextMatchMatchup(match: match),
            SizedBox(height: 16),
            NextMatchInfo(match: match),
          ],
        ),
      ),
    );
  }
}
