import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:nuliga_app/model/validation_result.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_shared.dart';
import 'package:nuliga_app/services/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_urls.dart';

class ClubEditDialogStepLeagueUrl extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onUrlChanged;

  const ClubEditDialogStepLeagueUrl({
    super.key,
    required this.initialValue,
    required this.onUrlChanged,
  });

  @override
  State<ClubEditDialogStepLeagueUrl> createState() =>
      _ClubEditDialogStepLeagueUrlState();
}

class _ClubEditDialogStepLeagueUrlState
    extends State<ClubEditDialogStepLeagueUrl> {
  late TextEditingController _rankingUrlController;
  final settingsService = SettingsService();
  Timer? _debounceTimer;

  late Future<ValidationResult> _rankingUrlCachedFuture;

  @override
  void initState() {
    super.initState();
    _rankingUrlController = TextEditingController(text: widget.initialValue);
    _rankingUrlCachedFuture = _checkRankingUrlValid(_rankingUrlController.text);

    _rankingUrlController.addListener(() {
      widget.onUrlChanged(_rankingUrlController.text);

      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          developer.log(
            'debounce timer over, checking ranking url validity',
            name: 'ClubEditDialogStepLeagueUrl',
          );
          _rankingUrlCachedFuture = _checkRankingUrlValid(
            _rankingUrlController.text,
          );
        });
      });
    });
  }

  @override
  void didUpdateWidget(ClubEditDialogStepLeagueUrl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      _rankingUrlCachedFuture = _checkRankingUrlValid(
        _rankingUrlController.text,
      );
    }
  }

  Future<ValidationResult> _checkRankingUrlValid(String rankingUrl) async {
    developer.log('checking ranking url', name: 'ClubEditDialogStepLeagueUrl');
    return settingsService.validateRankingTableUrl(rankingUrl);
  }

  @override
  void dispose() {
    _rankingUrlController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationResult>(
      future: _rankingUrlCachedFuture,
      builder: (context, asyncSnapshot) {
        final isRankingUrlValid = getDataOrDefault(
          asyncSnapshot,
          ValidationResult.unknown,
        );

        return Column(
          children: [
            const SizedBox(height: 8),
            buildDialogTextField(
              'Liga Überblick URL',
              _rankingUrlController,
              isValid: isRankingUrlValid,
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
                      await HttpUrls.openUrl("https://badminton.liga.nu/");
                    },
                    icon: Icon(Icons.open_in_new),
                  ),
                  child: Text("Öffne die Website deines Verbandes"),
                ),
                const SizedBox(height: 8),
                _TutorialRow(
                  index: 2,
                  subtitle: Text(
                    'Beispiel: BWBV-Ligen > Landesliga "Oberrhein"',
                  ),
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
        );
      },
    );
  }

  Future<ValidationResult> validateRankingTableUrl(String rankingUrl) {
    if (rankingUrl.isEmpty) {
      return Future.value(ValidationResult.unknown);
    }

    return settingsService.validateRankingTableUrl(rankingUrl);
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
