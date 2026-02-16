import 'package:flutter/material.dart';

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

  Image getIcon() {
    switch (mood) {
      case 1:
        return Image.asset('images/moods/cry.png', width: 30);
      case 2:
        return Image.asset('images/moods/sad.png', width: 30);
      case 3:
        return Image.asset('images/moods/angry.png', width: 30);
      case 4:
        return Image.asset('images/moods/meh.png', width: 30);
      case 5:
        return Image.asset('images/moods/happy.png', width: 30);
      default:
        return Image.asset('images/moods/very-happy.png', width: 30);
    }
  }

  @override
  toString() => 'Mood {createdAt: $createdAt, mood: $mood}';

}