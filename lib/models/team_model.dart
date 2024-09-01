
class Team {
  final String id;
  final String club;
  final String name;
  final String location;
  final String agebracket;
  

  Team({required this.id,required this.club, required this.name, required this.location,required this.agebracket});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      club: json['club'],
      name: json['name'],
      location: json['location'],
      agebracket: json['agebracket'],
    );
  }
}