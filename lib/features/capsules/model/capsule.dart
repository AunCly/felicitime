class Capsule {

  int id;
  String title;
  String description;
  Duration duration;


  /// Tags associated with the capsule
  /// e.g. 'free', 'premium', 'all_price', 'all_seasons', 'spring', 'summer', 'autumn', 'winter', 'all_family', etc.
  ///
  /// Family tags: 'all_family', 'yes', 'near', 'no'
  /// Price tags: 'all_price', 'free', 'little', 'high'
  /// Season tags: 'all_season', 'spring', 'summer', 'autumn', 'winter'
  ///
  List<String> tags;

  Capsule({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.tags,
  });

  factory Capsule.fromJson(json) => Capsule(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: Duration(minutes: json["duration_minutes"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "duration_minutes": duration.inMinutes,
    "tags": tags,
  };

  @override
  toString() => 'Capsule {id: $id, title: $title}';

}