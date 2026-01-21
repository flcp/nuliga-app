import 'package:flutter/material.dart';

class ClubEditDialogStep4 extends StatelessWidget {
  final String rankingUrl;
  final String shortName;
  final String selectedTeamName;

  const ClubEditDialogStep4({
    super.key,
    required this.rankingUrl,
    required this.shortName,
    required this.selectedTeamName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text("Liga Überblick URL"), subtitle: Text(rankingUrl)),
        ListTile(title: Text("Team"), subtitle: Text(selectedTeamName)),
        ListTile(title: Text("Team Kürzel"), subtitle: Text(shortName)),
      ],
    );
  }
}
