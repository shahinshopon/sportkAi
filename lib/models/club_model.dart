// for empty screen
class Club {
  String? id;
  final String clubName;

  Club({ this.id, required this.clubName});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      clubName: json['club'],
    );
  }
}

//for view screen
class Match {
  final String awayName;
  final String homeName;
  final int awayScore;
  final int homeScore;
  final DateTime matchDatetime;

  Match({
    required this.awayName,
    required this.homeName,
    required this.awayScore,
    required this.homeScore,
    required this.matchDatetime,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      awayName: json['away_name'],
      homeName: json['home_name'],
      awayScore: json['away_score'],
      homeScore: json['home_score'],
      matchDatetime: DateTime.parse(json['match_datetime']),
    );
  }
}


