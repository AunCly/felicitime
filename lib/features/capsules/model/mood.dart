import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {

  final DateTime createdAt;
  final int mood;

  static const moods = [
    1, // Very Sad
    2, // Sad
    3, // Neutral
    4, // Happy
    5, // Very Happy
  ];

  Mood({
    required this.createdAt,
    required this.mood,
  });

  factory Mood.fromJson(json) => Mood(
    createdAt: DateTime.parse(json["created_at"]),
    mood: json["mood"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "mood": mood,
  };

  IconData getIcon() {
    switch (mood) {
      case 1:
        return FontAwesomeIcons.lightFaceSadCry;
      case 2:
        return FontAwesomeIcons.lightFaceFrown;
      case 3:
        return FontAwesomeIcons.lightFaceAngry;
      case 4:
        return FontAwesomeIcons.lightFaceMeh;
      case 5:
        return FontAwesomeIcons.lightFaceSmile;
      default:
        return FontAwesomeIcons.lightFaceLaugh;
    }
  }

  @override
  toString() => 'Mood {createdAt: $createdAt, mood: $mood}';

}