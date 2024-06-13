class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String telephoneNumber;
  final String profilePhoto;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.telephoneNumber,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      telephoneNumber: json['telephone_number'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
    );
  }
}
