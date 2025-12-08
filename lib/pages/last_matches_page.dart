import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/last-matches/last_matches_page_content.dart';

class LastMatchesPage extends StatelessWidget {
  const LastMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ergebnisse")),
      body: Column(
        children: [FollowedTeamNavigation(), LastMatchesPageContent()],
      ),
    );
  }
}
