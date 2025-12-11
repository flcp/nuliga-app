import 'package:flutter/material.dart';
import 'package:nuliga_app/nuliga_app.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final followedTeamsProvider = FollowedTeamsProvider();
  await followedTeamsProvider.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: followedTeamsProvider,
      child: MaterialApp(
        home: const NuligaApp(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
      ),
    ),
  );
}
