
class NewsModel {
  final int id;
  final Admin? admin; // Nullable
  final Category? category; // Nullable
  final String title;
  final String content;
  final int totalLikes;
  final List<File> files;
  final String updatedAt;

  NewsModel({
    required this.id,
    this.admin,
    this.category,
    required this.title,
    required this.content,
    required this.totalLikes,
    required this.files,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    var filesFromJson = json['files'] as List? ?? []; // Safe handling of null
    List<File> fileList = filesFromJson.map((i) => File.fromJson(i)).toList();

    return NewsModel(
      id: json['id'] ?? 0,
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      totalLikes: json['total_likes'] ?? 0,
      files: fileList,
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin': admin?.toJson(),
      // 'category': category?.toJson(),
      'title': title,
      'content': content,
      'total_likes': totalLikes,
      // 'files': files.map((file) => file.toJson()).toList(),
      'updated_at': updatedAt,
    };
  }
}

// user
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

// admin
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
      id: json['id']??0,
      name: json['name']??'',
      description: json['description']??'',
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
      id: json['id']??0,
      newsId: json['news_id']??'',
      path: json['path']??'',
    );
  }

 String get url {
    if (path.startsWith('http')) {
      return path;
    }
    return 'https://storage.googleapis.com/e-complaint-assets/$path';
  }
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
      user: json.containsKey('user') && json['user'] != null ? User.fromJson(json['user']) : null,
      admin: json.containsKey('admin') && json['admin'] != null ? Admin.fromJson(json['admin']) : null,
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
