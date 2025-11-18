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

  IconData getIcon() {
    switch (mood) {
      case 1:
        return Icons.sentiment_very_dissatisfied;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
        return Icons.sentiment_satisfied;
      case 5:
        return Icons.sentiment_very_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  @override
  toString() => 'Mood {createdAt: $createdAt, mood: $mood}';

}