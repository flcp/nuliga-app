import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class NextMatchCountdown extends StatelessWidget {
  const NextMatchCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(Constants.smallCardPadding),
      ),
    );
  }
}
