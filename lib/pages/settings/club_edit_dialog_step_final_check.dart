import 'package:flutter/material.dart';

class ClubEditDialogStepFinalCheck extends StatelessWidget {
  final String rankingUrl;
  final String shortName;
  final String selectedTeamName;
  final String matchesUrl;

  const ClubEditDialogStepFinalCheck({
    super.key,
    required this.rankingUrl,
    required this.shortName,
    required this.selectedTeamName,
    required this.matchesUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Icon(Icons.check, color: Colors.green),
          title: Text("Liga Überblick URL"),
          subtitle: Text(rankingUrl),
        ),
        ListTile(
          trailing: Icon(Icons.check, color: Colors.green),
          title: Text("Spielplan URL"),
          subtitle: Text(matchesUrl),
        ),
        ListTile(
          trailing: Icon(Icons.check, color: Colors.green),
          title: Text("Team"),
          subtitle: Text(selectedTeamName),
        ),
        ListTile(
          trailing: Icon(Icons.close, color: Colors.red),
          title: Text("Team Kürzel"),
          subtitle: Text(shortName),
        ),
      ],
    );
  }
}
