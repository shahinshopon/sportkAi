class Age {
  final int name;

  Age({required this.name});

  factory Age.fromJson(Map<String, dynamic> json) {
    return Age(
      name: json['name'],
    );
  }
}

class Location {
  final String name;

  Location({required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
    );
  }
}

class Sex {
  final String name;

  Sex({required this.name});

  factory Sex.fromJson(Map<String, dynamic> json) {
    return Sex(
      name: json['name'],
    );
  }
}
