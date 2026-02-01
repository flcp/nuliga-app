import 'package:flutter/material.dart';
import 'package:nuliga_app/services/shared/model/validation_result.dart';

Widget buildDialogTextField(
  String label,
  TextEditingController controller, {
  ValidationResult isValid = ValidationResult.unknown,
  String? validationText,
}) {
  final validColor = Colors.green;
  final invalidColor = Colors.red;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: switch (isValid) {
      ValidationResult.unknown => const BorderSide(width: 2),
      ValidationResult.valid => BorderSide(color: validColor, width: 2),
      ValidationResult.invalid => BorderSide(color: invalidColor, width: 2),
    },
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
      if (isValid == ValidationResult.invalid &&
          validationText != null &&
          validationText.isNotEmpty) ...[
        const SizedBox(height: 4),
        Text(
          validationText,
          style: TextStyle(fontSize: 12, color: invalidColor),
        ),
      ],
    ],
  );
}
