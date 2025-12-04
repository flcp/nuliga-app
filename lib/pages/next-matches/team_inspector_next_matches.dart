import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';

class TeamInspectorNextMatches extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const TeamInspectorNextMatches({
    super.key,
    required this.teamName,
    required this.matchOverviewUrl,
  });

  @override
  State<TeamInspectorNextMatches> createState() =>
      _TeamInspectorNextMatchesState();
}

class _TeamInspectorNextMatchesState extends State<TeamInspectorNextMatches> {
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
          //todo extract
          return const Center(child: CircularProgressIndicator());
        }

        final nextMatches = getDataOrEmptyList(snapshot);

        return RefreshIndicator(
          onRefresh: () => refresh(),
          child: Stack(
            children: [
              if (nextMatches.isEmpty)
                Center(
                  child: Text(
                    "Nothing to display. Try refreshing or another URL",
                  ),
                ),

              ListView(
                children: nextMatches
                    .map(
                      (match) => ListTile(
                        selected: isOnNextMatchDay(match, nextMatches),
                        leading: SizedBox(
                          width: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${match.time.day}.${match.time.month}.${match.time.year}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          match.homeTeam == widget.teamName
                              ? match.opponentTeam
                              : match.homeTeam,
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
