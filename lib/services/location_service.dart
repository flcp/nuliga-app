import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/matches/next-matches/match_location_repository.dart';

class LocationService {
  final matchLocationRepository = MatchLocationRepository();

  Future<String> getLocationMapsLink(FutureMatch match) async {
    if (match.locationUrl.isEmpty) return Future.value("");

    final locationAddress = await matchLocationRepository.getMatchLocation(
      match.locationUrl,
    );

    return convertToGoogleMapsLink(locationAddress);
  }

  Future<String> getLocation(FutureMatch match) async {
    if (match.locationUrl.isEmpty) return Future.value("");

    return matchLocationRepository.getMatchLocation(match.locationUrl);
  }

  static List<String> convertToMultilineAddress(String address) {
    if (address.isEmpty) {
      return [];
    }

    final plzRegex = RegExp(r'\d{5}');

    final parts = address.split(plzRegex);
    final plz = plzRegex.allMatches(address);
    if (parts.length < 2 || plz.isEmpty) return parts;

    return [parts[0], "${plz.first.group(0)!} ${parts[1]}"];
  }

  static String convertToGoogleMapsLink(String address) {
    final encodedAddress = Uri.encodeComponent(address);

    return "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
  }
}
