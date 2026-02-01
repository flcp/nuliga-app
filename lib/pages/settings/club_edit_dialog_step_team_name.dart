import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
import 'package:nuliga_app/services/league-table/model/league_team_ranking.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/settings/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ClubEditDialogStepTeamName extends StatefulWidget {
  final String initialValue;
  final String rankingUrl;
  final ValueChanged<String> onTeamNameChanged;

  const ClubEditDialogStepTeamName({
    super.key,
    required this.initialValue,
    required this.rankingUrl,
    required this.onTeamNameChanged,
  });

  @override
  State<ClubEditDialogStepTeamName> createState() =>
      _ClubEditDialogStepTeamNameState();
}

class _ClubEditDialogStepTeamNameState
    extends State<ClubEditDialogStepTeamName> {
  final SettingsService settingsService = SettingsService();

  late Future<List<LeagueTeamRanking>> _teamRankingsFuture;

  @override
  void initState() {
    super.initState();
    _teamRankingsFuture = _loadTeamRankings();
  }

  Future<List<LeagueTeamRanking>> _loadTeamRankings() {
    developer.log('loading team rankings', name: 'ClubEditDialogStepTeamName');
    return settingsService.fetchTeamRankings(widget.rankingUrl);
  }

  @override
  void didUpdateWidget(ClubEditDialogStepTeamName oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.rankingUrl != widget.rankingUrl) {
      _teamRankingsFuture = _loadTeamRankings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return widget.rankingUrl.isEmpty
        ? Text(l10n.pleaseEnterLeagueUrlInStep1)
        : FutureBuilder<List<LeagueTeamRanking>>(
            future: _teamRankingsFuture,
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
                            ? Text(l10n.team)
                            : Text(l10n.noTeamFound),
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
