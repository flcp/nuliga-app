class FollowedClub {
  final String name;
  final String shortName;
  final String rankingTableUrl;
  final String matchesUrl;

  FollowedClub({
    required this.name,
    required this.shortName,
    required this.rankingTableUrl,
    required this.matchesUrl,
  });

  FollowedClub copyWith({
    String? name,
    String? shortName,
    String? rankingTableUrl,
    String? matchesUrl,
  }) {
    return FollowedClub(
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      rankingTableUrl: rankingTableUrl ?? this.rankingTableUrl,
      matchesUrl: matchesUrl ?? this.matchesUrl,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'shortName': shortName,
    'rankingTableUrl': rankingTableUrl,
    'matchesUrl': matchesUrl,
  };

  factory FollowedClub.fromJson(Map<String, dynamic> json) => FollowedClub(
    name: json['name'] as String,
    shortName: json['shortName'] as String,
    rankingTableUrl: json['rankingTableUrl'] as String,
    matchesUrl: json['matchesUrl'] as String,
  );
}
