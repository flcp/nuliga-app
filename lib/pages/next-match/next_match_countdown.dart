import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class NextMatchCountdown extends StatefulWidget {
  const NextMatchCountdown({super.key, required this.matchTime});
  
  final DateTime matchTime;

  @override
  State<NextMatchCountdown> createState() => _NextMatchCountdownState();
}

class _NextMatchCountdownState extends State<NextMatchCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.matchTime.difference(now);
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();}

  @override
  Widget build(BuildContext context) {
   final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _timeBox(days, "Tage"),
                _timeBox(hours, "Std"),
                _timeBox(minutes, "Min"),
                _timeBox(seconds, "Sek"),
              ],),
      ),
    );
  }
}

// TODO: colors, size
  Widget _timeBox(int value, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
