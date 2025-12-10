import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Duration cooldown = Duration(seconds: 30);

class CachedResponse {
  final DateTime lastRequestTime;
  final String lastResponseBody;

  CachedResponse(this.lastRequestTime, this.lastResponseBody);
}

Map<String, CachedResponse> cache = {};

Future<void> clearCache() {
  cache.removeWhere((_, _) => true);
  return Future.value();
}

Future<String> fetchWebsiteCached(String url) async {
  // TODO: REMOVE
  var loadSSC1FromFiles = false;
  if (loadSSC1FromFiles) {
    var mockedWebsite = await fetchWebsiteMocked(url);
    if (mockedWebsite.isNotEmpty) {
      return mockedWebsite;
    }
  }

  final now = DateTime.now();
  final previousResponse = cache[url];
  if (previousResponse != null) {
    if (now.difference(previousResponse.lastRequestTime) < cooldown) {
      print("serving cached response from ${previousResponse.lastRequestTime}");
      return previousResponse.lastResponseBody;
    }
  }

  final responseBody = await fetchWebsite(url);
  cache[url] = CachedResponse(now, responseBody);

  return responseBody;
}

Future<String> fetchWebsiteMocked(String url) async {
  if (url ==
      "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307") {
    print("serving league overview from file");
    return await rootBundle.loadString(
      "lib/services/shared/assets/league_overview.html",
    );
  } else if (url ==
      "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307") {
    print("serving matches overview from file");
    return await rootBundle.loadString(
      "lib/services/shared/assets/all_matches.html",
    );
  }
  return "";
}

Future<String> fetchWebsite(String urlString) async {
  final url = Uri.parse(urlString);

  try {
    final response = await http.get(url);
    return response.body;
  } catch (e) {
    return "";
  }
}

String getBaseUrl(String url) {
  final uri = Uri.parse(url);

  return "${uri.scheme}://${uri.host}";
}
