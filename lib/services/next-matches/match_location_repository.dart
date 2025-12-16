import 'package:nuliga_app/services/next-matches/match_location_parser.dart';
import 'package:nuliga_app/services/shared/http.dart';

class MatchLocationRepository {
  final httpClient = HttpClient();

  Future<String> getMatchLocation(String locationUrl) async {
    final htmlContent = await httpClient.get(locationUrl);
    return MatchLocationParser.getLocationAdress(htmlContent);
  }
}
