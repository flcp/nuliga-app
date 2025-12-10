import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';

class FollowedTeamsProvider extends ChangeNotifier {
  late List<FollowedClub> _followedTeams = [];
  late String? _selectedTeamId;

  List<FollowedClub> get followedTeams => _followedTeams;

  FollowedClub? get selectedFollowedTeam {
    if (_selectedTeamId == null) {
      return null;
    }

    return _followedTeams.firstWhere((c) => c.id == _selectedTeamId);
  }

  Future<void> initialize() async {
    _followedTeams = navigationItems;

    if (_followedTeams.isNotEmpty) {
      _selectedTeamId = _followedTeams.first.id;
    }
  }

  void selectTeam(FollowedClub? team) {
    _selectedTeamId = team?.id;
    notifyListeners();
  }
}

final navigationItems = [
  FollowedClub(
    id: "1",
    name: "SSC Karlsruhe",
    shortName: "SSC I",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307",
  ),
  FollowedClub(
    id: "2",
    name: "SSC Karlsruhe II",
    shortName: "SSC II",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  FollowedClub(
    id: "3",
    name: "SSC Karlsruhe III",
    shortName: "SSC III",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  FollowedClub(
    id: "4",
    name: "SSC Karlsruhe IV",
    shortName: "SSC IV",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35328",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35328",
  ),
];
