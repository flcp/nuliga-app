import 'dart:async';

import 'package:flutter/material.dart';
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

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _matchupsUrlController = TextEditingController(text: widget.initialValue);
    _matchupsUrlController.addListener(() {
      widget.onMatchupsUrlChanged(_matchupsUrlController.text);

      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _matchupsUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: settingsService.validateMatchupsUrl(_matchupsUrlController.text),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final isValid = getDataOrDefault(snapshot, false);

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

  void _fillMatchupsUrlFromRankingUrl() async {
    final generatedUrl = await settingsService.getMatchupsUrlFromRankingUrl(
      widget.rankingUrl,
    );

    setState(() {
      _matchupsUrlController.text = generatedUrl;
    });
  }
}
