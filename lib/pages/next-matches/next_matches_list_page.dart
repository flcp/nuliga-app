import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_page_content.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class NextMatchesListPage extends StatelessWidget {
  final FollowedClub team;
  const NextMatchesListPage({required this.team, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nächste Matches"),
        actions: [
          ActionBarOpenLinkButton(
            selectedFollowedTeam: team,
            urlAccessor: (i) => i.matchesUrl,
          ),
        ],
      ),
      body: NextMatchesListPageContent(team: team),
    );
  }
}
