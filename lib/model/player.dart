import 'dart:developer' as developer;

class Player {
  final String firstName;
  final String lastName;

  Player({required this.firstName, required this.lastName});

  factory Player.fromCommaSeparatedString(String name) {
    final nameParts = name.split(",");

    if (nameParts.length < 2) {
      developer.log(
        "Cannot parse name, returning name as firstName only",
        name: "nuliga.warning",
      );
      return Player(firstName: name, lastName: "");
    }

    return Player(firstName: nameParts[1], lastName: nameParts[0]);
  }

  static Player absent = Player(firstName: "Nicht angetreten", lastName: "");
  static Player unknown = Player(firstName: "Unbekannt", lastName: "");

  String getFullname() {
    return "$firstName $lastName";
  }
}
