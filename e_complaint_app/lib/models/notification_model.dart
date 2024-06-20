class NotificationModel{
  final int id;
  final String updatedAt;
  
  NotificationModel({
    required this.id,
    required this.updatedAt,
  });
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

