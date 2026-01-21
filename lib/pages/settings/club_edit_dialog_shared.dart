import 'package:flutter/material.dart';

Widget buildDialogTextField(
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
