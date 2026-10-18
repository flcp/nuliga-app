import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/league-table/model/league_team_ranking.dart';
import 'package:nuliga_app/pages/team-details/team_details_league_team_inspector.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';

class LeagueTableDetailsRankingListItem extends StatefulWidget {
  const LeagueTableDetailsRankingListItem({
    super.key,
    required this.teamStanding,
    required this.team,
    required this.matchOverviewUrl,
  });

  final LeagueTeamRanking teamStanding;
  final String team;
  final String matchOverviewUrl;

  @override
  State<LeagueTableDetailsRankingListItem> createState() =>
      _LeagueTableDetailsRankingListItemState();
}

class _LeagueTableDetailsRankingListItemState
    extends State<LeagueTableDetailsRankingListItem> {
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final subTitleStyle = Theme.of(context).textTheme.bodySmall;
    final padding = Constants.smallCardPadding / 2;

    return InkWell(
      onTap: goToTeamInspector,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(widget.teamStanding.rank.toString(), style: titleStyle),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.teamStanding.teamName, style: titleStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            'Played: ${widget.teamStanding.totalMatches}',
                            style: subTitleStyle,
                          ),
                          SizedBox(width: 16),
                          WinLossIndicator(
                            size: 8,
                            status: MatchResultStatus.win,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Wins: ${widget.teamStanding.wins}',
                            style: subTitleStyle,
                          ),
                          SizedBox(width: 16),
                          WinLossIndicator(
                            size: 8,
                            status: MatchResultStatus.draw,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Draws: ${widget.teamStanding.draws}',
                            style: subTitleStyle,
                          ),
                          SizedBox(width: 16),
                          WinLossIndicator(
                            size: 8,
                            status: MatchResultStatus.loss,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Losses: ${widget.teamStanding.losses}',
                            style: subTitleStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.teamStanding.leaguePointsWon.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Divider(
            height: Constants.bigCardPadding,
            thickness: 1,
            color: Theme.of(context).dividerColor.withValues(alpha: 0.35),
          ),
        ],
      ),
    );
  }

  void goToTeamInspector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsLeagueTeamInspector(
          teamName: widget.teamStanding.teamName,
          matchOverviewUrl: widget.matchOverviewUrl,
        ),
      ),
    );
  }
}
