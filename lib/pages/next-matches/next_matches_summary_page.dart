import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_summary_list.dart';

class NextMatchesSummaryPage extends StatelessWidget {
  const NextMatchesSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nächste Matches"),
        // TODO: Move to content
        // actions: [
        //   ActionBarOpenLinkButton(
        //     selectedFollowedTeam: selectedFollowedTeam,
        //     urlAccessor: (i) => i.matchesUrl,
        //   ),
        // ],
      ),
      body: NextMatchesSummaryList(),
    );
  }
}
