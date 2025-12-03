import 'package:nuliga_app/model/club_navigation_item.dart';

class FavoriteClubsService {
static final navigationItems = [
    ClubNavigationItem(
      name: "SSC Karlsruhe",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe II",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe III",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35309",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35309",
    ),
    ClubNavigationItem(
      name: "SSC Karlsruhe IV",
      tableUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35328",
      matchesUrl:
          "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35328",
    ),
  ];

  static Future<List<ClubNavigationItem>> getFavoriteClubs() {
    return Future.value(navigationItems);
  }
}

