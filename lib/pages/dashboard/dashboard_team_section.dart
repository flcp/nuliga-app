import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/dashboard/dashboard_section.dart';
import 'package:nuliga_app/pages/dashboard/last-matches/last_matches.dart';
import 'package:nuliga_app/pages/dashboard/league-info/league_info.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';

class DashboardTeamSection extends StatefulWidget {
  final FollowedClub team;

  const DashboardTeamSection({super.key, required this.team});

  @override
  State<DashboardTeamSection> createState() => _DashboardTeamSectionState();
}

class _DashboardTeamSectionState extends State<DashboardTeamSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeagueInfo(team: widget.team),
        SizedBox(height: 16),
        NextMatches(matchesUrl: widget.team.matchesUrl, team: widget.team),
        SizedBox(height: 16),
        DashboardSection(
          title: localization.last,
          child: LastMatches(team: widget.team),
          onViewAll: () => goToResults(widget.team),
        ),
        SizedBox(height: 48),
      ],
    );
  }

  void goToResults(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 2),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
