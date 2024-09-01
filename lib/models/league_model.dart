
class League {
  final String location;
  final String agebracket;

  League({required this.location, required this.agebracket});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      location: json['location'],
      agebracket: json['agebracket'],
    );
  }
}