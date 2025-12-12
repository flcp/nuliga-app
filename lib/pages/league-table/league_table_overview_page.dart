import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/league-table/league_table_overview_list.dart';

class LeagueTableOverviewPage extends StatelessWidget {
  const LeagueTableOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabelle")),
      body: LeagueTableOverviewList(),
    );
  }
}
