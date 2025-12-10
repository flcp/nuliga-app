import 'package:flutter/material.dart';
import 'package:nuliga_app/model/club_navigation_item.dart';

class FollowedTeamsProvider extends ChangeNotifier {
  late List<ClubNavigationItem> _followedTeams = [];
  late String? _selectedTeamId;

  List<ClubNavigationItem> get followedTeams => _followedTeams;

  ClubNavigationItem? get selectedFollowedTeam {
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

  void selectTeam(ClubNavigationItem? team) {
    _selectedTeamId = team?.id;
    notifyListeners();
  }
}

final navigationItems = [
  ClubNavigationItem(
    id: "1",
    name: "SSC Karlsruhe",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307",
  ),
  ClubNavigationItem(
    id: "2",
    name: "SSC Karlsruhe II",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  ClubNavigationItem(
    id: "3",
    name: "SSC Karlsruhe III",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
  ),
  ClubNavigationItem(
    id: "4",
    name: "SSC Karlsruhe IV",
    tableUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35328",
    matchesUrl:
        "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35328",
  ),
];
