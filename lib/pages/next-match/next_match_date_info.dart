import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/shared/date.dart';

class NextMatchDateInfo extends StatelessWidget {
  const NextMatchDateInfo({super.key, required this.matchTime});
  final DateTime matchTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(Icons.calendar_today, size: 18),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Date.getLongDateString(matchTime),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "${matchTime.hour}:${matchTime.minute.toString().padLeft(2, "0")} Uhr",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
