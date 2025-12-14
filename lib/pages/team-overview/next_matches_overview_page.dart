import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/team-overview/next_matches_overview_list.dart';

class NextMatchesOverviewPage extends StatelessWidget {
  const NextMatchesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Overview")),
      body: NextMatchesOverviewList(),
    );
  }
}
