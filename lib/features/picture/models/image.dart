import 'package:mime/mime.dart';

class MediaModel {
  final int id;
  final String name;
  final String fileName;
  final String url;
  final String originalUrl;
  final bool isHttp;
  final bool isImage;

  MediaModel({
    required this.id,
    required this.name,
    required this.fileName,
    required this.url,
    required this.originalUrl,
    required this.isImage,
    this.isHttp = false,
  });

  factory MediaModel.fromJson(json) => MediaModel(
    id: json["id"],
    name: json["name"],
    fileName: json["file_name"],
    url: json["url"],
    originalUrl: json["original_url"],
    isImage: json['is_image'],
    isHttp: true,
  );

  factory MediaModel.fromPath(String path) => MediaModel(
    id: 0,
    name: path.split('/').last,
    fileName: path.split('/').last,
    url: path,
    originalUrl: path,
    isImage: lookupMimeType(path)!.contains('image'),
  );

}