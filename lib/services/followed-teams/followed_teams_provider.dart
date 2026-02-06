import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';

class FollowedTeamsProvider extends ChangeNotifier {
  late List<FollowedClub> _followedTeams = [];
  late SharedPreferences _prefs;

  static const String _storageKey = 'followed_clubs';

  List<FollowedClub> get followedTeams => _followedTeams;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final jsonString = _prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _followedTeams = decoded
            .map((item) => FollowedClub.fromJson(item as Map<String, dynamic>))
            .toList();
        notifyListeners();
      } catch (e) {
        developer.log('Error loading followed clubs: $e');
        _loadDefaults();
      }
    } else {
      _loadDefaults();
    }
  }

  void _loadDefaults() {
    _followedTeams = navigationItems;
    _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    final jsonString = jsonEncode(
      _followedTeams.map((c) => c.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, jsonString);
  }

  Future<void> addClub(FollowedClub club) async {
    _followedTeams = [..._followedTeams, club];
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> removeClub(int index) async {
    _followedTeams = [..._followedTeams]..removeAt(index);
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> updateClub(int index, FollowedClub club) async {
    _followedTeams = [
      for (int i = 0; i < _followedTeams.length; i++)
        if (i == index) club else _followedTeams[i],
    ];
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> reorderClub(int oldIndex, int newIndex) async {
    final item = _followedTeams.removeAt(oldIndex);
    final adjustedIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    _followedTeams.insert(adjustedIndex, item);
    notifyListeners();
    await _saveToStorage();
  }
}

final navigationItems = [
  FollowedClub(
    name: "SSC Karlsruhe",
    shortName: "SSC I",
    rankingTableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307",
  ),
  FollowedClub(
    name: "SSC Karlsruhe II",
    shortName: "SSC II",
    rankingTableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  FollowedClub(
    name: "SSC Karlsruhe III",
    shortName: "SSC III",
    rankingTableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  FollowedClub(
    name: "SSC Karlsruhe IV",
    shortName: "SSC IV",
    rankingTableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35328",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35328",
  ),
];
