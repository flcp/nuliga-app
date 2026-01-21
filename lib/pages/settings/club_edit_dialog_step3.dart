import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/settings/club_edit_dialog_shared.dart';

class ClubEditDialogStep3 extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onShortNameChanged;

  const ClubEditDialogStep3({
    super.key,
    required this.initialValue,
    required this.onShortNameChanged,
  });

  @override
  State<ClubEditDialogStep3> createState() => _ClubEditDialogStep3State();
}

class _ClubEditDialogStep3State extends State<ClubEditDialogStep3> {
  late TextEditingController _shortNameController;

  @override
  void initState() {
    super.initState();
    _shortNameController = TextEditingController(text: widget.initialValue);
    _shortNameController.addListener(() {
      widget.onShortNameChanged(_shortNameController.text);
    });
  }

  @override
  void dispose() {
    _shortNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        const SizedBox(height: 8),
        buildDialogTextField(
          'Team Kürzel',
          _shortNameController,
          // isValid: isShortNameValid,
          validationText: "Kürzel darf maximal 7 Zeichen lang sein",
        ),
      ],
    );
  }
}
