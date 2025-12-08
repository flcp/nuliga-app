import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_page_content.dart';

class NextMatchesPage extends StatelessWidget {
  const NextMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nächste Matches")),
      body: Column(
        children: [FollowedTeamNavigation(), NextMatchesPageContent()],
      ),
    );
  }
}
