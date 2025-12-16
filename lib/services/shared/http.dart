import 'package:http/http.dart' as http;

class HttpClient {
  static final HttpClient _instance = HttpClient._privateConstructor();
  late final HttpClientCache cache;

  HttpClient._privateConstructor() {
    cache = HttpClientCache();
  }

  factory HttpClient() => _instance;

  void clearCache() {
    cache.clearCache();
  }

  Future<String> get(String url) async {
    final cachedResult = cache.get(url);
    if (cachedResult.isNotEmpty) {
      return cachedResult;
    }

    final responseBody = await _fetchWebsiteOrEmpty(url);

    if (responseBody.isNotEmpty) {
      cache.set(url, responseBody);
    }

    return responseBody;
  }

  static String getBaseUrl(String url) {
    final uri = Uri.parse(url);

    return "${uri.scheme}://${uri.host}";
  }

  Future<String> _fetchWebsiteOrEmpty(String urlString) async {
    final url = Uri.parse(urlString);

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      print("error fetching website $e");
      return "";
    }
  }
}

class CachedResponse {
  final DateTime lastRequestTime;
  final String lastResponseBody;

  CachedResponse(this.lastRequestTime, this.lastResponseBody);
}

class HttpClientCache {
  Map<String, CachedResponse> cache = {};
  final cooldown = Duration(seconds: 120);

  void clearCache() {
    cache.removeWhere((_, _) => true);
  }

  String get(String url) {
    final now = DateTime.now();
    final previousResponse = cache[url];
    if (previousResponse != null) {
      if (now.difference(previousResponse.lastRequestTime) < cooldown) {
        print(
          "serving cached response from ${previousResponse.lastRequestTime}",
        );
        return previousResponse.lastResponseBody;
      }
    }
    return "";
  }

  void set(String url, String responseBody) {
    final now = DateTime.now();
    cache[url] = CachedResponse(now, responseBody);
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
