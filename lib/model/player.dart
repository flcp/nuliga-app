import 'dart:developer' as developer;

class Player {
  final String firstName;
  final String lastName;

  Player({required this.firstName, required this.lastName});

  factory Player.fromCommaSeparatedString(String name) {
    final nameParts = name.split(",");

    if (nameParts.length < 2) {
      developer.log(
        "Cannot parse name, returning Unknown Unknown",
        name: "nuliga.warning",
      );
      return Player(firstName: "Unknown", lastName: "Unknown");
    }

    return Player(firstName: nameParts[1], lastName: nameParts[0]);
  }

  String getFullname() {
    return "$firstName $lastName";
  }
}
