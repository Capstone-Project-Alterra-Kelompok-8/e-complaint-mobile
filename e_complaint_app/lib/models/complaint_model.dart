class Complaint {
  final String id;
  final User user;
  final Category category;
  final Regency regency;
  final String address;
  final String description;
  final String status;
  final String type;
  final List<FileModel> files;

  Complaint({
    required this.id,
    required this.user,
    required this.category,
    required this.regency,
    required this.address,
    required this.description,
    required this.status,
    required this.type,
    required this.files,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    var list = json['files'] as List? ?? [];
    List<FileModel> filesList = list.map((i) => FileModel.fromJson(i)).toList();

    return Complaint(
      id: json['id'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      category: Category.fromJson(json['category'] ?? {}),
      regency: Regency.fromJson(json['regency'] ?? {}),
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      files: filesList,
    );
  }
}

class ComplaintResponse {
  final bool status;
  final String message;
  final Complaint? complaint;

  ComplaintResponse({
    required this.status,
    required this.message,
    this.complaint,
  });

  factory ComplaintResponse.fromJson(Map<String, dynamic> json) {
    return ComplaintResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      complaint: json['data'] != null ? Complaint.fromJson(json['data']) : null,
    );
  }
}

class User {
  final int id;
  final String name;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
    );
  }
}

class Regency {
  final String id;
  final String name;

  Regency({
    required this.id,
    required this.name,
  });

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['ID'] ?? '',
      name: json['Name'] ?? '',
    );
  }
}

class FileModel {
  final int id;
  final String complaintId;
  final String path;

  FileModel({
    required this.id,
    required this.complaintId,
    required this.path,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] ?? 0,
      complaintId: json['complaint_id'] ?? '',
      path: json['path'] ?? '',
    );
  }
}
