class MediaModel {
  final String path;

  MediaModel({
    required this.path,
  });

  factory MediaModel.fromJson(json) => MediaModel(
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
  };

}