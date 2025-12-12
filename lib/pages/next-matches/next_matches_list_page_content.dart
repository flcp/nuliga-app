import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list.dart';

class NextMatchesListPageContent extends StatelessWidget {
  final FollowedClub team;

  const NextMatchesListPageContent({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NextMatchesList(
            teamName: team.name,
            matchOverviewUrl: team.matchesUrl,
          ),
        ),
      ],
    );
  }
}
