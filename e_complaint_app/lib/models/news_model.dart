import 'package:e_complaint_app/models/my_complaint_model.dart';

class NewsModel {
  final int id;
  final Admin admin;
  final Category category;
  final String title;
  final String content;
  final int totalLikes;
  final List<File> files;
  final String updatedAt;

  NewsModel({
    required this.id,
    required this.admin,
    required this.category,
    required this.title,
    required this.content,
    required this.totalLikes,
    required this.files,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    var filesFromJson = json['files'] as List;
    List<File> fileList = filesFromJson.map((i) => File.fromJson(i)).toList();

    return NewsModel(
      id: json['id'],
      admin: Admin.fromJson(json['admin']),
      category: Category.fromJson(json['category']),
      title: json['title'],
      content: json['content'],
      totalLikes: json['total_likes'],
      files: fileList,
      updatedAt: json['updated_at'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  
}

class Admin {
  final int id;
  final String name;
  final String email;
  final String password;
  final String telephoneNumber;
  final bool isSuperAdmin;
  final String profilePhoto;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.telephoneNumber,
    required this.isSuperAdmin,
    required this.profilePhoto,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id']??'',
      name: json['name']??'',
      email: json['email']??  '',
      password: json['password']??'',
      telephoneNumber: json['telephone_number']??'',
      isSuperAdmin: json['is_super_admin']??'',
      profilePhoto: json['profile_photo']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'telephone_number': telephoneNumber,
      'is_super_admin': isSuperAdmin,
      'profile_photo': profilePhoto,
    };
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class File {
  final int id;
  final int newsId;
  final String path;

  File({
    required this.id,
    required this.newsId,
    required this.path,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      newsId: json['news_id'],
      path: json['path'],
    );
  }

  String get url => 'https://storage.googleapis.com/e-complaint-assets/${this.path}';
}



// news comment
class NewsCommentModel {
  final int id;
  final User? user;
  final Admin? admin;
  final String comment;
  final String updatedAt;

  NewsCommentModel({
    required this.id,
    this.user,
    this.admin,
    required this.comment,
    required this.updatedAt,
  });

  factory NewsCommentModel.fromJson(Map<String, dynamic> json) {
    return NewsCommentModel(
      id: json['id']??'',
      user: json.containsKey('user') ? User.fromJson(json['user']) : null,
      admin: json.containsKey('admin') ? Admin.fromJson(json['admin']) : null,
      comment: json['comment']??'',
      updatedAt: json['update_at']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'admin': admin?.toJson(),
      'comment': comment,
      'updated_at': updatedAt,
    };
  }
}
