import 'package:flutter/material.dart';

class TeamInspectorNextMatches extends StatelessWidget {
  const TeamInspectorNextMatches({
    super.key, required String teamName, required url,
  });

  String getMatchesOverviewUrl() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Content'));
  }
}