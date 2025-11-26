import 'package:http/http.dart' as http;

Duration cooldown = Duration(seconds: 30);

class CachedResponse {
  final DateTime lastRequestTime;
  final String lastResponseBody;

  CachedResponse(this.lastRequestTime, this.lastResponseBody);
}

Map<String, CachedResponse> cache = {};

Future<String> fetchWebsiteCached(String url) async {
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

Future<String> fetchWebsite(String urlString) async {
  final url = Uri.parse(urlString);

  try {
    final response = await http.get(url);
    return response.body;
  } catch (e) {
    return "";
  }
}
