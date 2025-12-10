import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';

class NextMatchesList extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const NextMatchesList({
    super.key,
    required this.teamName,
    required this.matchOverviewUrl,
  });

  @override
  State<NextMatchesList> createState() => _NextMatchesListState();
}

class _NextMatchesListState extends State<NextMatchesList> {
  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FutureMatch>>(
      future: NextMatchesService.getNextMatchesForTeam(
        widget.matchOverviewUrl,
        widget.teamName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final nextMatches = getDataOrEmptyList(snapshot);

        return RefreshIndicator(
          onRefresh: () => refresh(),
          child: Stack(
            children: [
              if (nextMatches.isEmpty) NothingToDisplayIndicator(),

              ListView(
                children: nextMatches
                    .map(
                      (match) => ListTile(
                        selected: isOnNextMatchDay(match, nextMatches),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "${match.time.day}.${match.time.month}.${match.time.year}",
                              ),
                            ),
                            Text(
                              "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
                            ),
                          ],
                        ),
                        title: Text(
                          match.homeTeam == widget.teamName
                              ? match.opponentTeam
                              : match.homeTeam,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.directions),
                          onPressed: () {
                            print(match.locationUrl);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isOnNextMatchDay(FutureMatch match, List<FutureMatch> nextMatches) {
    final nextMatchTime = nextMatches
        .map((m) => m.time)
        .toList()
        .reduce((min, e) => e.isBefore(min) ? e : min);

    return match.time.day == nextMatchTime.day &&
        match.time.month == nextMatchTime.month &&
        match.time.year == nextMatchTime.year;
  }
}
