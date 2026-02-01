import 'dart:developer' as developer;

import 'package:html/dom.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class MatchLocationParser {
  static String getLocationAdress(String html) {
    if (html.trim().isEmpty) return "";

    final document = parser.parse(html);

    // Find the <h2> that contains "Hallenadresse"
    Element? hallenadresseHeader;

    try {
      hallenadresseHeader = document
          .querySelectorAll('h2')
          .firstWhere((e) => e.text.trim() == 'Hallenadresse');
    } on StateError {
      developer.log("No location address found", level: 1200);
      return "";
    }

    // The address is inside the next <p> element
    final p = hallenadresseHeader.nextElementSibling;
    if (p == null) return "";

    final lines = p.nodes
        .whereType<dom.Text>()
        .map((textNode) => textNode.text.trim().replaceAll(RegExp(r'\s+'), " "))
        .where((text) => text.isNotEmpty)
        .toList();

    if (lines.length < 2) return lines[0];

    return "${lines[0]} ${lines[1]}";
  }
}
