import 'dart:convert';

// MyComplaintModel model
class MyComplaintModel {
  final String id;
  final User user;
  final Category category;
  final Regency regency;
  final String address;
  final String description;
  final String status;
  final String type;
  final List<ComplaintFile> files;
  final String updatedAt;

  MyComplaintModel({
    required this.id,
    required this.user,
    required this.category,
    required this.regency,
    required this.address,
    required this.description,
    required this.status,
    required this.type,
    required this.files,
    required this.updatedAt,
  });

  factory MyComplaintModel.fromJson(Map<String, dynamic> json) {
    return MyComplaintModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
      regency: Regency.fromJson(json['regency']),
      address: json['address'],
      description: json['description'],
      status: json['status'],
      type: json['type'],
      files: json['files'] != null
        ? List<ComplaintFile>.from(json['files'].map((x) => ComplaintFile.fromJson(x)))
        : [],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'category': category.toJson(),
      'regency': regency.toJson(),
      'address': address,
      'description': description,
      'status': status,
      'type': type,
      'files': List<dynamic>.from(files.map((x) => x.toJson())),
      'updated_at': updatedAt,
    };
  }
}

// User model
class User {
  int id;
  String name;
  String email;
  String telephoneNumber;
  String profilePhoto;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.telephoneNumber,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephoneNumber: json['telephone_number'],
      profilePhoto: json['profile_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'telephone_number': telephoneNumber,
      'profile_photo': profilePhoto,
    };
  }
}

// Category model
class Category {
  int id;
  String name;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

// Regency model
class Regency {
  String id;
  String name;

  Regency({
    required this.id,
    required this.name,
  });

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// ComplaintFile model
class ComplaintFile {
  int id;
  String complaintId;
  String path;

  ComplaintFile({
    required this.id,
    required this.complaintId,
    required this.path,
  });

  factory ComplaintFile.fromJson(Map<String, dynamic> json) {
    return ComplaintFile(
      id: json['id'],
      complaintId: json['complaint_id'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complaint_id': complaintId,
      'path': path,
    };
  }
}
