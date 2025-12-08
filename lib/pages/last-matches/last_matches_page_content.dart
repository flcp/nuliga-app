import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

class LastMatchesPageContent extends StatelessWidget {
  const LastMatchesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTeam = context
        .watch<FollowedTeamsProvider>()
        .selectedFollowedTeam;

    if (selectedTeam == null) {
      Center(child: Text("Keine Teams gefollowed oder ausgewählt."));
    }

    return Expanded(
      child: LastMatchesList(
        teamName: selectedTeam!.name,
        matchOverviewUrl: selectedTeam.matchesUrl,
      ),
    );
  }
}

class LastMatchesList extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const LastMatchesList({
    super.key,
    required this.matchOverviewUrl,
    required this.teamName,
  });

  @override
  State<LastMatchesList> createState() => _LastMatchesListState();
}

class _LastMatchesListState extends State<LastMatchesList> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.teamName));
  }
}
