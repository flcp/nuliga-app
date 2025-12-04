import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/followed_team_navigation.dart';

class LeagueTable extends StatelessWidget {
  const LeagueTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabelle")),
      body: Column(
        children: [
          FollowedTeamNavigation(),
          Center(child: Text("contnt")),
        ],
      ),
    );
  }
}
