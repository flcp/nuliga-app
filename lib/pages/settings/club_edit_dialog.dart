import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/settings_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubEditPage extends StatefulWidget {
  final FollowedClub? club;

  const ClubEditPage({super.key, this.club});

  @override
  State<ClubEditPage> createState() => _ClubEditPageState();
}

class _ClubEditPageState extends State<ClubEditPage> {
  int _currentStepIndex = 0;

  late TextEditingController _rankingUrlController;
  bool? _isRankingUrlValid;
  Timer? _rankingUrlDebounceTimer;

  late TextEditingController _shortNameController;
  bool? _isShortNameValid;

  String? _selectedTeamName;

  final settingsService = SettingsService();

  List<LeagueTeamRanking> _teamRankings = [];

  @override
  void initState() {
    super.initState();

    _rankingUrlController = TextEditingController(
      text: widget.club?.rankingTableUrl ?? '',
    );
    _rankingUrlController.addListener(_onRankingUrlChanged);

    _shortNameController = TextEditingController(
      text: widget.club?.shortName ?? '',
    );
    _shortNameController.addListener(_onShortNameChanged);
  }

  @override
  void dispose() {
    _rankingUrlController.dispose();
    _shortNameController.dispose();
    super.dispose();
  }

  List<Step> buildSteps() {
    return [
      _createFirstStep(),
      _createSecondStep(),
      _createThirdStep(),
      _createFourthStep(),
    ];
  }

  void _onRankingUrlChanged() async {
    _rankingUrlDebounceTimer?.cancel();
    if (_rankingUrlController.text.isEmpty) {
      setState(() {
        _isRankingUrlValid = null;
        _selectedTeamName = null;
        _teamRankings = [];
      });
      return;
    }

    _rankingUrlDebounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        final isValid = await _validateRankingUrl(_rankingUrlController.text);

        final teamRankings = isValid
            ? await settingsService.fetchTeamRankings(
                _rankingUrlController.text,
              )
            : <LeagueTeamRanking>[];

        setState(() {
          _teamRankings = teamRankings;
          _isRankingUrlValid = isValid;
        });
      },
    );
  }

  void _onShortNameChanged() {
    if (_shortNameController.text.isEmpty) {
      setState(() => _isShortNameValid = null);
      return;
    }

    final isValid = _shortNameController.text.length <= 7;
    setState(() {
      _isShortNameValid = isValid;
    });
  }

  Future<bool> _validateRankingUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasAbsolutePath) {
      return false;
    }

    return settingsService.validateRankingTableUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final steps = buildSteps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.club == null ? 'Club hinzufügen' : 'Club bearbeiten',
        ),
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
                  child: Text('Zurück'),
                ),
                SizedBox(width: 10),
                FilledButton(
                  onPressed: details.onStepContinue,
                  child: Text('Weiter'),
                ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStepIndex >= steps.length - 1) {
            final club = FollowedClub(
              name: _selectedTeamName ?? "Umbenannt",
              shortName: _shortNameController.text,
              rankingTableUrl: _rankingUrlController.text,
              matchesUrl: "",
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

  Step _createFirstStep() {
    return Step(
      title: Text("URL hinzufügen"),
      content: Column(
        children: [
          const SizedBox(height: 8),
          _buildTextField(
            'Liga Überblick URL',
            _rankingUrlController,
            isValid: _isRankingUrlValid,
            validationText: "Ungültige URL",
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),

            title: Text("Anleitung"),
            children: [
              _TutorialRow(
                index: 1,
                subtitle: Text("Beispiel: https://bwbv-badminton.liga.nu"),
                trailing: IconButton(
                  onPressed: () async {
                    var uri = Uri.parse("https://badminton.liga.nu/");
                    await launchUrl(uri);
                  },
                  icon: Icon(Icons.open_in_new),
                ),
                child: Text("Öffne die Website deines Verbandes"),
              ),
              const SizedBox(height: 8),
              _TutorialRow(
                index: 2,
                subtitle: Text('Beispiel: BWBV-Ligen > Landesliga "Oberrhein"'),
                child: Text("Navigiere zur Liga deines Vereines"),
              ),
              const SizedBox(height: 8),
              _TutorialRow(
                index: 3,
                child: Text("Kopiere die URL und füge sie oben ein"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Step _createSecondStep() {
    return Step(
      title: Text("Team auswählen"),
      content: Column(
        children: [
          const SizedBox(height: 8),
          DropdownMenu<LeagueTeamRanking>(
            width: double.infinity,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            label: _isRankingUrlValid ?? false
                ? Text("Team")
                : Text("Kein Team gefunden"),
            enabled: _isRankingUrlValid ?? false,
            initialSelection: _selectedTeamName == null
                ? _teamRankings.firstOrNull
                : _teamRankings.firstWhere(
                    (team) => team.teamName == _selectedTeamName,
                    orElse: () => _teamRankings.first,
                  ),
            onSelected: (LeagueTeamRanking? value) {
              setState(() {
                _selectedTeamName = value?.teamName;
              });
            },
            dropdownMenuEntries: _teamRankings.map((teamRanking) {
              return DropdownMenuEntry<LeagueTeamRanking>(
                value: teamRanking,
                label: teamRanking.teamName,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Step _createThirdStep() {
    return Step(
      title: Text("Kürzel eingeben"),
      content: Column(
        children: [
          SizedBox(height: 8),
          const SizedBox(height: 8),
          _buildTextField(
            'Team Kürzel',
            _shortNameController,
            isValid: _isShortNameValid,
            validationText: "Kürzel darf maximal 7 Zeichen lang sein",
          ),
        ],
      ),
    );
  }

  Step _createFourthStep() {
    return Step(
      title: Text("Überprüfen"),
      content: Column(
        children: [
          ListTile(
            title: Text("Liga Überblick URL"),
            subtitle: Text(_rankingUrlController.text),
          ),
          ListTile(
            title: Text("Team"),
            subtitle: Text(_selectedTeamName ?? 'Kein Team ausgewählt'),
          ),
          ListTile(
            title: Text("Team Kürzel"),
            subtitle: Text(_shortNameController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool? isValid,
    String? validationText,
  }) {
    final validColor = Colors.green;
    final invalidColor = Colors.red;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: isValid != null
          ? BorderSide(color: isValid ? validColor : invalidColor, width: 2)
          : const BorderSide(width: 2),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
        if (isValid == false && validationText != null) ...[
          const SizedBox(height: 4),
          Text(
            validationText,
            style: TextStyle(fontSize: 12, color: invalidColor),
          ),
        ],
      ],
    );
  }
}

class _TutorialRow extends StatelessWidget {
  final Widget child;
  final int index;
  final Widget? trailing;
  final Widget? subtitle;

  const _TutorialRow({
    required this.child,
    required this.index,
    this.trailing,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$index.", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyLarge!,
                child: child,
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
                child: subtitle ?? Container(),
              ),
            ],
          ),
        ),
        trailing ?? Container(),
      ],
    );
  }
}
