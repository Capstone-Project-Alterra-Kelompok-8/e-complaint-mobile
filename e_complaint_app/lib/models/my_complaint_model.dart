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
  final String date;
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
    required this.date,
    required this.files,
    required this.updatedAt,
  });

  factory MyComplaintModel.fromJson(Map<String, dynamic> json) {
    // Check if 'files' is a list before mapping it
    List<ComplaintFile> fileList = [];
    if (json['files'] != null && json['files'] is List) {
      fileList = (json['files'] as List).map((i) => ComplaintFile.fromJson(i)).toList();
    }

    return MyComplaintModel(
      id: json['id'] ?? '',
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
      regency: Regency.fromJson(json['regency']),
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      date: json['date'] ?? '',
      files: fileList,
      updatedAt: json['updated_at'] ?? '',
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
      'date': date,
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
      id: json['id']??'',
      name: json['name']??'',
      email: json['email']??'',
      telephoneNumber: json['telephone_number']??'',
      profilePhoto: json['profile_photo']??'',
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

  String get url {
    if (profilePhoto.startsWith('http')) {
      return profilePhoto;
    }
    return 'https://storage.googleapis.com/e-complaint-assets/$profilePhoto';
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
      id: json['id']??'',
      name: json['name']??'',
      description: json['description']??'',
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
      id: json['id']??'',
      name: json['name']??'',
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
      id: json['id'] ,
      complaintId: json['complaint_id'] ,
      path: json['path'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complaint_id': complaintId,
      'path': path,
    };
  }

  String get url {
    if (path.startsWith('http')) {
      return path;
    }
    return 'https://storage.googleapis.com/e-complaint-assets/$path';
  }
}


class MyComplaintProsesModel {
  final String status;
  final Admin admin;
  final String date;
  final String message;

  MyComplaintProsesModel({
    required this.status,
    required this.admin,
    required this.date,
    required this.message,
  });

  factory MyComplaintProsesModel.fromJson(Map<String, dynamic> json) {
    return MyComplaintProsesModel(
      status: json['status'] ?? '',
      admin: Admin.fromJson(json['admin']),
      date: json['updated_at'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'admin': admin.toJson(),
      'date': date,
      'message': message,
    };
  }
}

class Admin {
  final int id;
  final String name;
  final String profilePhoto;

  Admin({
    required this.id,
    required this.name,
    required this.profilePhoto,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id']??0,
      name: json['name']??'',
      profilePhoto: json['profile_photo']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_photo': profilePhoto,
    };
  }

  String get url {
    if (profilePhoto.startsWith('http')) {
      return profilePhoto;
    }
    return 'https://storage.googleapis.com/e-complaint-assets/$profilePhoto';
  }
}


class CommentModel {
  final int id;
  final String complaintId;
  final User? user;
  final Admin? admin;
  final String comment;
  final String date;

  CommentModel({
    required this.id,
    required this.complaintId,
    required this.user,
    required this.admin,
    required this.comment,
    required this.date,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id']??'',
      complaintId: json['complaint_id']??'',
      user: json.containsKey('user') ? User.fromJson(json['user']) : null,
      admin: json.containsKey('admin') ? Admin.fromJson(json['admin']) : null,
      comment: json['comment']??'',
      date: json['updated_at']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complaint_id': complaintId,
      'user': user?.toJson(),
      'admin': admin?.toJson(),
      'comment': comment,
      'updated_at': date,
    };
  }
}