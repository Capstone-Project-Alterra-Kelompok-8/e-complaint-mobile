class UserRegisterModel {
  final String name;
  final String email;
  final String telephoneNumber;
  final String password;

  UserRegisterModel({
    required this.name,
    required this.email,
    required this.telephoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'telephone_number': telephoneNumber,
      'password': password,
    };
  }
}
