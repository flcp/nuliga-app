import 'package:flutter/material.dart';
import 'package:nuliga_app/bottom_navigation.dart';
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
        home: const BottomNavigation(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.redAccent.shade200,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.grey.shade50,
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade50),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.grey.shade100, width: 1),
            ),
          ),
        ),
      ),
    ),
  );
}
