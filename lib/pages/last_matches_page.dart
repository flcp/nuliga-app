import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';
import 'package:nuliga_app/pages/last-matches/last_matches_page_content.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LastMatchesPage extends StatelessWidget {
  const LastMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFollowedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedFollowedTeam == null) {
      return const Center(child: Text('No club selected'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Ergebnisse"),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () async {
              var uri = Uri.parse(selectedFollowedTeam.matchesUrl);
              await launchUrl(uri);
            },
          ),
        ],
      ),
      body: Column(
        children: [FollowedTeamNavigation(), LastMatchesPageContent()],
      ),
    );
  }
}
