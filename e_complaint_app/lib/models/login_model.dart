class LoginResponse {
  final bool status;
  final String message;
  final UserData data;

  LoginResponse({required this.status, required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String token;

  UserData({required this.id, required this.name, required this.email, required this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}
