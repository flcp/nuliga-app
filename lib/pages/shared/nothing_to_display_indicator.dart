import 'package:flutter/material.dart';

// TODO: use again

class NothingToDisplayIndicator extends StatelessWidget {
  const NothingToDisplayIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Nothing to display. Try refreshing or another URL"),
    );
  }
}
