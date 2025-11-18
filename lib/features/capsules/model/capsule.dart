class Capsule {

  int id;
  String title;
  String description;
  Duration duration;
  List<String> tags;

  Capsule({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.tags
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
  toString() => 'User {id: $id, title: $title, description: $description}';

}