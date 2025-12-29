import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/parser.dart';

class NextMatchPage extends StatelessWidget {
  final FutureMatch match;

  final nextMatchesService = NextMatchesService();

  NextMatchPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next match")),
      body: Padding(
        padding: const EdgeInsets.all(Constants.pagePadding),
        child: Column(
          children: [
            Card(),
            Card(
              child: Container(
                padding: const EdgeInsets.all(24),
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
            ),
            SizedBox(height: 16),
            Card(
              child: FutureBuilder(
                future: nextMatchesService.getLocation(match),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center();
                  }

                  final data = getDataOrDefault(asyncSnapshot, "");
                  final location = NextMatchesService.getMultilineAddress(data);

                  return Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            const SizedBox(width: 12),
                            Text("Datum"),
                            const Spacer(),
                            Text(getLongDateString(match.time)),
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
                        // TODO: remove paddings for sizedbox and spacer
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingMatchScreen extends StatefulWidget {
  const UpcomingMatchScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingMatchScreen> createState() => _UpcomingMatchScreenState();
}

class _UpcomingMatchScreenState extends State<UpcomingMatchScreen> {
  late Timer _timer;
  Duration _timeRemaining = const Duration(days: 2, hours: 15, minutes: 30);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining.inSeconds > 0) {
          _timeRemaining -= const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Nächstes Spiel',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Countdown Timer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E2875), Color(0xFF2D3A8C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'SPIEL BEGINNT IN',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTimeUnit(days, 'Tage'),
                        _buildTimeUnit(hours, 'Std'),
                        _buildTimeUnit(minutes, 'Min'),
                        _buildTimeUnit(seconds, 'Sek'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Teams
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151B3D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    // Heimmannschaft
                    _buildTeam('SC Karlsruhe', '3.', true, Icons.home),

                    const SizedBox(height: 20),

                    // VS Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(0.2)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'VS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(0.2)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Auswärtsmannschaft
                    _buildTeam(
                      'FC Bayern München',
                      '1.',
                      false,
                      Icons.flight_takeoff,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Match Details
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151B3D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      Icons.calendar_today,
                      'Datum',
                      '31. Dezember 2025',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(Icons.access_time, 'Anstoß', '18:30 Uhr'),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      Icons.location_on,
                      'Stadion',
                      'Wildparkstadion, Karlsruhe',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C6FFF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tickets kaufen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeUnit(int value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatTime(value),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTeam(String name, String rank, bool isHome, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHome ? const Color(0xFF4C6FFF) : const Color(0xFFFF4C6F),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Platz $rank',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            rank,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4C6FFF), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
