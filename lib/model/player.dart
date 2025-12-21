// ignore_for_file: non_constant_identifier_names

class Player {
  final String firstName;
  final String lastName;

  Player({required this.firstName, required this.lastName});

  factory Player.fromCommaSeparatedString(String name) {
    final nameParts = name.split(",");

    if (nameParts.length < 2) {
      print("Cannot parse name");
      return Player(firstName: "Unknown", lastName: "Unknown");
    }

    return Player(firstName: nameParts[1], lastName: nameParts[0]);
  }

  String getFullname() {
    return "$firstName $lastName";
  }
}
