import 'package:intl/intl.dart';

class Complaint {
  final String id;
  final String name;
  final String categoryName;
  final String regencyName;
  final String description;
  final String status;
  final String profilePhoto;
  final List<String> files;
  final int totalLikes;
  final String date;
  final DateTime updatedAt;

  Complaint({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.regencyName,
    required this.description,
    required this.status,
    required this.profilePhoto,
    required this.files,
    required this.totalLikes,
    required this.date,
    required this.updatedAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'https://storage.googleapis.com/e-complaint-assets/';
    DateFormat dateFormat = DateFormat("d MMMM yyyy HH:mm:ss");

    return Complaint(
      id: json['id'],
      name: json['user']['name'],
      categoryName: json['category']['name'],
      regencyName: json['regency']['name'],
      description: json['description'],
      status: json['status'],
      profilePhoto: baseUrl + json['user']['profile_photo'],
      files: (json['files'] as List<dynamic>?)
              ?.map((file) => baseUrl + file['path'].toString())
              .toList() ??
          [],
      totalLikes: json['total_likes'],
      date: json['date'],
      updatedAt: dateFormat.parse(json['updated_at']),
    );
  }
}
