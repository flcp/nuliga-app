import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_page_content.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class NextMatchesPage extends StatelessWidget {
  const NextMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    // Padding(
    //         padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
    //         child: ChoiceChip(
    //           labelPadding: const EdgeInsets.symmetric(horizontal: 0),
    //           label: Icon(
    //             Icons.chevron_left,
    //             color: Theme.of(context).colorScheme.onSecondaryContainer,
    //           ),
    //           onSelected: (_) {
    //             provider.selectTeam(null);
    //           },
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30),
    //             side: BorderSide.none,
    //           ),
    //           selected: true,
    //           selectedColor: Theme.of(context).colorScheme.surfaceBright,
    //           showCheckmark: false,
    //         ),
    //       ),

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
      body: NextMatchesPageContent(),
    );
  }
}
