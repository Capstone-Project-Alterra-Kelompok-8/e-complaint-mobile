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
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'https://storage.googleapis.com/e-complaint-assets/';
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
      totalLikes: json['total_likes']
    );
  }
}
