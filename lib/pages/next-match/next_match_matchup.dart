import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class NextMatchMatchup extends StatelessWidget {
  const NextMatchMatchup({super.key, required this.match});

  final FutureMatch match;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Column(
          children: [
            Text(match.homeTeam),
            Row(
              children: [
                Expanded(child: Divider()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("VS"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            Text(match.opponentTeam),
          ],
        ),
      ),
    );
  }
}
