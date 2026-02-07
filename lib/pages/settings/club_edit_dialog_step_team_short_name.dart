import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/shared/model/validation_result.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_shared.dart';
import 'package:nuliga_app/services/settings/settings_service.dart';

class ClubEditDialogStepShortName extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onShortNameChanged;

  const ClubEditDialogStepShortName({
    super.key,
    required this.initialValue,
    required this.onShortNameChanged,
  });

  @override
  State<ClubEditDialogStepShortName> createState() =>
      _ClubEditDialogStepShortNameState();
}

class _ClubEditDialogStepShortNameState
    extends State<ClubEditDialogStepShortName> {
  late TextEditingController _shortNameController;

  final settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _shortNameController = TextEditingController(text: widget.initialValue);
    _shortNameController.addListener(() {
      widget.onShortNameChanged(_shortNameController.text);

      setState(() {});
    });
  }

  @override
  void dispose() {
    _shortNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        const SizedBox(height: 8),
        buildDialogTextField(
          localization.teamShortName,
          _shortNameController,
          isValid: validateShortName(_shortNameController.text),
          validationText: localization.shortNameMaxLength,
        ),
      ],
    );
  }

  ValidationResult validateShortName(String shortName) {
    if (shortName.isEmpty) {
      return ValidationResult.unknown;
    }

    return settingsService.validateShortName(shortName);
  }
}
