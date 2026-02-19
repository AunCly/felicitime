import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/picture/models/image.dart';

class Moment {

  Capsule capsule;
  DateTime createdAt;
  List<MediaModel> medias;
  String? comment;
  bool isFavorite;

  Moment({
    required this.capsule,
    required this.createdAt,
    required this.medias,
    this.comment,
    this.isFavorite = false,
  });

  factory Moment.fromJson(json, capsule) => Moment(
    capsule: capsule,
    createdAt: DateTime.parse(json["created_at"]),
    medias: List<MediaModel>.from(json["medias"].map((x) => MediaModel.fromJson(x))),
    comment: json["comment"],
    isFavorite: json["is_favorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "capsule_id": capsule.id,
    "created_at": createdAt.toIso8601String(),
    "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
    "comment": comment,
    "is_favorite": isFavorite,
  };

  @override
  toString() => 'Moment {capsule: $capsule, createdAt: $createdAt, medias: $medias}';

}