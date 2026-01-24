import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:nuliga_app/model/validation_result.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_shared.dart';
import 'package:nuliga_app/services/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ClubEditDialogStepMatchupsUrl extends StatefulWidget {
  final String initialValue;
  final String rankingUrl;
  final ValueChanged<String> onMatchupsUrlChanged;

  const ClubEditDialogStepMatchupsUrl({
    super.key,
    required this.initialValue,
    required this.rankingUrl,
    required this.onMatchupsUrlChanged,
  });

  @override
  State<ClubEditDialogStepMatchupsUrl> createState() =>
      _ClubEditDialogStepMatchupsUrlState();
}

class _ClubEditDialogStepMatchupsUrlState
    extends State<ClubEditDialogStepMatchupsUrl> {
  late TextEditingController _matchupsUrlController;
  final settingsService = SettingsService();

  late Future<ValidationResult> _matchupsUrlCachedFuture;

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _matchupsUrlController = TextEditingController(text: widget.initialValue);
    _matchupsUrlCachedFuture = validateMatchupsUrl(_matchupsUrlController.text);
    _matchupsUrlController.addListener(() {
      widget.onMatchupsUrlChanged(_matchupsUrlController.text);

      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
        developer.log(
          'debounce timer over, checking matchups url validity',
          name: 'ClubEditDialogStepMatchupsUrl',
        );
        setState(() {
          _matchupsUrlCachedFuture = _checkMatchupsUrlValid();
        });
      });
    });
  }

  Future<ValidationResult> _checkMatchupsUrlValid() {
    developer.log(
      'checking matchups url',
      name: 'ClubEditDialogStepMatchupsUrl',
    );
    return validateMatchupsUrl(_matchupsUrlController.text);
  }

  @override
  void dispose() {
    _matchupsUrlController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationResult>(
      future: _matchupsUrlCachedFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final isValid = getDataOrDefault(snapshot, ValidationResult.unknown);

        return Column(
          children: [
            const SizedBox(height: 8),
            buildDialogTextField(
              "Spielplan (Gesamt) URL",
              _matchupsUrlController,
              isValid: isValid,
              validationText: "Ungültige URL",
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_matchupsUrlController.text.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Überschreiben bestätigen'),
                      content: const Text(
                        'Möchten Sie die aktuelle Spielplan URL wirklich überschreiben?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Abbrechen'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();

                            _fillMatchupsUrlFromRankingUrl();
                          },
                          child: const Text('Überschreiben'),
                        ),
                      ],
                    ),
                  );
                } else {
                  _fillMatchupsUrlFromRankingUrl();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_fix_high),
                  const SizedBox(width: 8),
                  const Text('Aus Liga URL generieren'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<ValidationResult> validateMatchupsUrl(String matchupsUrl) {
    if (matchupsUrl.isEmpty) {
      return Future.value(ValidationResult.unknown);
    }
    return settingsService.validateMatchupsUrl(matchupsUrl);
  }

  void _fillMatchupsUrlFromRankingUrl() async {
    final generatedUrl = await settingsService.getMatchupsUrlFromRankingUrl(
      widget.rankingUrl,
    );

    setState(() {
      _matchupsUrlController.text = generatedUrl;
    });
  }
}
