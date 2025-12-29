import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class NextMatchInfo extends StatelessWidget {
  const NextMatchInfo({
    super.key,
    required this.nextMatchesService,
    required this.match,
  });

  final NextMatchesService nextMatchesService;
  final FutureMatch match;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.smallCardPadding),
        child: FutureBuilder(
          future: nextMatchesService.getLocation(match),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center();
            }

            final data = getDataOrDefault(asyncSnapshot, "");
            final location = NextMatchesService.getMultilineAddress(data);

            return Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today),
                    const SizedBox(width: 12),
                    Text("Datum"),
                    const Spacer(),
                    Text(Date.getLongDateString(match.time)),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.access_time),
                    const SizedBox(width: 12),
                    Text("Uhrzeit"),
                    const Spacer(),
                    Text(
                      "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")} Uhr",
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.location_on),
                    const SizedBox(width: 12),
                    Text("Location"),
                    const SizedBox(width: 24),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: location
                            .map(
                              (locationPart) => Text(
                                locationPart,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.right,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
