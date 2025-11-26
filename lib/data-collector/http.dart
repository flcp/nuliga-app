import 'package:http/http.dart' as http;

DateTime? _lastRequestTime;
String? _lastResponseBody;
// todo remove
Duration cooldown = Duration(seconds: 30);

Future<String> fetchWebsite(String urlString) async {
  final now = DateTime.now();

  if (_lastRequestTime != null &&
      now.difference(_lastRequestTime!) < cooldown &&
      _lastResponseBody != null) {
    print("Rate limiting hit");
    return _lastResponseBody!;
  }

  _lastRequestTime = now;

  final url = Uri.parse(urlString);

  try {
    final response = await http.get(url);
    _lastResponseBody = response.body;

    return response.body;
  } catch (e) {}

  return "";
}
