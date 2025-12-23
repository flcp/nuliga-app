import 'dart:developer' as developer;

import 'package:async/async.dart';
import 'package:http/http.dart' as http;

abstract class HttpClientInterface {
  Future<String> get(String url);
}

class HttpClient implements HttpClientInterface {
  static final HttpClient _instance = HttpClient._privateConstructor();
  final Map<String, AsyncCache<String>> _cache = {};

  HttpClient._privateConstructor();
  factory HttpClient() => _instance;

  void clearCache() {
    for (var asyncCache in _cache.values) {
      asyncCache.invalidate();
    }
  }

  @override
  Future<String> get(String url) async {
    _cache.putIfAbsent(url, () => AsyncCache<String>(Duration(minutes: 2)));

    return _cache[url]!.fetch(() => _fetchWebsiteOrEmpty(url));
  }

  static String getBaseUrl(String url) {
    final uri = Uri.parse(url);

    return "${uri.scheme}://${uri.host}";
  }

  Future<String> _fetchWebsiteOrEmpty(String urlString) async {
    final url = Uri.parse(urlString);

    developer.log("retrieving url $url", name: "info", level: 800);

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      developer.log("error fetching website", error: e, level: 1600);
      return "";
    }
  }
}

// Future<String> fetchWebsiteMocked(String url) async {
//   if (url ==
//       "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?championship=NB+25%2F26&group=35307") {
//     print("serving league overview from file");
//     return await rootBundle.loadString(
//       "lib/services/shared/assets/league_overview.html",
//     );
//   } else if (url ==
//       "https://bwbv-badminton.liga.nu/cgi-bin/WebObjects/nuLigaBADDE.woa/wa/groupPage?displayTyp=gesamt&displayDetail=meetings&championship=NB+25%2F26&group=35307") {
//     print("serving matches overview from file");
//     return await rootBundle.loadString(
//       "lib/services/shared/assets/all_matches.html",
//     );
//   }
//   return "";
// }
