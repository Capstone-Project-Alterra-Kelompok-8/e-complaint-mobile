class FileModel {
  final int id;
  final int newsId;
  final String path;

  FileModel({
    required this.id,
    required this.newsId,
    required this.path,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      newsId: json['news_id'],
      path: json['path'],
    );
  }
}