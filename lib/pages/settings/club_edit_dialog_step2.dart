import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ClubEditDialogStep2 extends StatefulWidget {
  final String initialValue;
  final String rankingUrl;
  final ValueChanged<String> onTeamNameChanged;

  const ClubEditDialogStep2({
    super.key,
    required this.initialValue,
    required this.rankingUrl,
    required this.onTeamNameChanged,
  });

  @override
  State<ClubEditDialogStep2> createState() => _ClubEditDialogStep2State();
}

class _ClubEditDialogStep2State extends State<ClubEditDialogStep2> {
  final SettingsService settingsService = SettingsService();

  @override
  Widget build(BuildContext context) {
    return widget.rankingUrl.isEmpty
        ? Text("Bitte Liga URL in Schritt 1 eingeben.")
        : FutureBuilder(
            future: settingsService.fetchTeamRankings(widget.rankingUrl),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<LeagueTeamRanking>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingIndicator();
                  }

                  final List<LeagueTeamRanking> teamRankings =
                      getDataOrEmptyList(snapshot);
                  final hasTeams = teamRankings.isNotEmpty;

                  final initialSelection = hasTeams
                      ? teamRankings.firstWhere(
                          (team) => team.teamName == widget.initialValue,
                          orElse: () => teamRankings.first,
                        )
                      : null;
                  widget.onTeamNameChanged(initialSelection?.teamName ?? "");

                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      DropdownMenu<LeagueTeamRanking>(
                        width: double.infinity,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        label: hasTeams
                            ? Text("Team")
                            : Text("Kein Team gefunden"),
                        enabled: hasTeams,
                        initialSelection: initialSelection,
                        onSelected: (selected) {
                          widget.onTeamNameChanged(selected?.teamName ?? "");
                        },
                        dropdownMenuEntries: teamRankings.map((teamRanking) {
                          return DropdownMenuEntry<LeagueTeamRanking>(
                            value: teamRanking,
                            label: teamRanking.teamName,
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
          );
  }
}
