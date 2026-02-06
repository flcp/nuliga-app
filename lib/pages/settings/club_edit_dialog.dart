import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_step_league_url.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_step_matchups_url.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_step_team_name.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_step_team_short_name.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_step_final_check.dart';
import 'package:nuliga_app/services/settings/settings_service.dart';

class ClubEditPage extends StatefulWidget {
  final FollowedClub? club;

  const ClubEditPage({super.key, this.club});

  @override
  State<ClubEditPage> createState() => _ClubEditPageState();
}

// setState is only called when changing steps. If you need setState of this file when any of the steps change data, refactor to use provider
class _ClubEditPageState extends State<ClubEditPage> {
  int _currentStepIndex = 0;

  late String _rankingUrl;
  late String _teamName;
  late String _shortName;
  late String _matchesUrl;

  final settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _rankingUrl = widget.club?.rankingTableUrl ?? "";
    _matchesUrl = widget.club?.matchesUrl ?? "";
    _teamName = widget.club?.name ?? "";
    _shortName = widget.club?.shortName ?? "";
  }

  List<Step> buildSteps() {
    final l10n = AppLocalizations.of(context)!;

    return [
      Step(
        title: Text(l10n.leagueUrl),
        content: ClubEditDialogStepLeagueUrl(
          initialValue: _rankingUrl,
          onUrlChanged: _onRankingUrlChanged,
        ),
      ),
      Step(
        title: Text(l10n.matchesUrl),
        content: ClubEditDialogStepMatchupsUrl(
          initialValue: _matchesUrl,
          rankingUrl: _rankingUrl,
          onMatchupsUrlChanged: _onMatchupsUrlChanged,
        ),
      ),
      Step(
        title: Text(l10n.team),
        content: ClubEditDialogStepTeamName(
          initialValue: _teamName,
          rankingUrl: _rankingUrl,
          onTeamNameChanged: _onTeamNameChanged,
        ),
      ),
      Step(
        title: Text(l10n.teamShortName),
        content: ClubEditDialogStepShortName(
          initialValue: _shortName,
          onShortNameChanged: _onShortNameChanged,
        ),
      ),
      Step(
        title: Text(l10n.review),
        content: ClubEditDialogStepFinalCheck(
          rankingUrl: _rankingUrl,
          matchesUrl: _matchesUrl,
          selectedTeamName: _teamName,
          shortName: _shortName,
        ),
      ),
    ];
  }

  void _onShortNameChanged(String value) {
    _shortName = value;
  }

  void _onRankingUrlChanged(String url) {
    _rankingUrl = url;
  }

  void _onTeamNameChanged(String value) {
    _teamName = value;
  }

  void _onMatchupsUrlChanged(String value) {
    _matchesUrl = value;
  }

  @override
  Widget build(BuildContext context) {
    final steps = buildSteps();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.club == null ? l10n.addClub : l10n.editClub),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        steps: steps,
        currentStep: _currentStepIndex,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(l10n.back_button),
                ),
                SizedBox(width: 10),
                FilledButton(
                  onPressed: details.onStepContinue,
                  child: Text(l10n.next_button),
                ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStepIndex >= steps.length - 1) {
            final club = FollowedClub(
              name: _teamName,
              shortName: _shortName,
              rankingTableUrl: _rankingUrl,
              matchesUrl: _matchesUrl,
            );
            Navigator.pop(context, club);

            return;
          }

          setState(() {
            _currentStepIndex += 1;
          });
        },
        onStepCancel: () {
          if (_currentStepIndex <= 0) {
            Navigator.pop(context);
            return;
          }

          setState(() {
            _currentStepIndex -= 1;
          });
        },
      ),
    );
  }
}
