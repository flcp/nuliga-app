import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Column(
          children: [
            Text(
              l10n.matchStartsIn,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _timeBox(days, l10n.days, Theme.of(context).colorScheme),
                _timeBox(hours, l10n.hours, Theme.of(context).colorScheme),
                _timeBox(minutes, l10n.minutes, Theme.of(context).colorScheme),
                _timeBox(seconds, l10n.seconds, Theme.of(context).colorScheme),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

Widget _timeBox(int value, String label, ColorScheme currentColorScheme) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: currentColorScheme.onPrimaryContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            color: currentColorScheme.onPrimary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: currentColorScheme.onPrimary.withAlpha(200),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
