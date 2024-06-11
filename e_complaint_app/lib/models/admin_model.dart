class AdminModel {
  final int id;
  final String username;
  final String telephoneNumber;
  final String email;
  final bool isSuperAdmin;
  final String profilePhoto;

  AdminModel({
    required this.id,
    required this.username,
    required this.telephoneNumber,
    required this.email,
    required this.isSuperAdmin,
    required this.profilePhoto,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      telephoneNumber: json['telephone_number'] ?? '',
      email: json['email'] ?? '',
      isSuperAdmin: json['is_super_admin'] ?? false,
      profilePhoto: json['profile_photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'telephone_number': telephoneNumber,
      'email': email,
      'is_super_admin': isSuperAdmin,
      'profile_photo': profilePhoto,
    };
  }
}
