import 'package:url_launcher/url_launcher.dart';

class HttpUrls {
  static bool isUrlValid(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Uri tryParse(String url) {
    try {
      final uri = Uri.parse(url);
      // testen mit Uri()
      return uri;
    } catch (e) {
      return Uri();
    }
  }

  static Future<void> openUrl(String url) async {
    if (!isUrlValid(url)) return;

    final uri = tryParse(url);

    if (uri.scheme.isEmpty) return;
    await launchUrl(uri);
  }
}
