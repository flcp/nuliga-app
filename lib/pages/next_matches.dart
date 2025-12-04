import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_content.dart';

class NextMatches extends StatelessWidget {
  const NextMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabelle")),
      body: Column(children: [FollowedTeamNavigation(), NextMatchesContent()]),
    );
  }
}
