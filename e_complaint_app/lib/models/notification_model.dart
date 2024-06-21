class NotificationModel{
  final int id;
  final DiscussionModel? discussion;
  final LikeModel? like;
  final String updatedAt;
  
  NotificationModel({
    required this.id,
    required this.discussion,
    required this.like,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']??0,
      discussion: json['discussion'] != null ? DiscussionModel.fromJson(json['discussion']) : null,
      like: json['like'] != null ? LikeModel.fromJson(json['like']) : null,
      updatedAt: json['update_at']??'',
    );
  }
}

// komen
class DiscussionModel{
  final int id;
  final Admin? admin;
  final User? user;
  final String comment;
  final String updatedAt;

  DiscussionModel({
    required this.id,
    required this.admin,
    required this.user,
    required this.comment,
    required this.updatedAt,
  });

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    return DiscussionModel(
      id: json['id']??0,
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      comment: json['comment']??'',
      updatedAt: json['update_at']??'',
    );
  }
}

// like
class LikeModel{
  final int id;
  final Admin? admin;
  final User? user;
  final String createdAt;

  LikeModel({
    required this.id,
    required this.admin,
    required this.user,
    required this.createdAt,
  });


  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id']??0,
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      createdAt: json['created_at']??'',
    );
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

