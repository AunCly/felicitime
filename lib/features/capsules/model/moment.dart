import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/picture/models/image.dart';

class Moment {

  Capsule capsule;
  DateTime createdAt;
  List<MediaModel> medias;

  Moment({
    required this.capsule,
    required this.createdAt,
    required this.medias,
  });

  factory Moment.fromJson(json) => Moment(
    capsule: Capsule.fromJson(json["capsule"]),
    createdAt: DateTime.parse(json["created_at"]),
    medias: List<MediaModel>.from(json["medias"].map((x) => MediaModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "capsule": capsule.toJson(),
    "created_at": createdAt.toIso8601String(),
    "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
  };

  @override
  toString() => 'Moment {capsule: $capsule, createdAt: $createdAt, medias: $medias}';

}