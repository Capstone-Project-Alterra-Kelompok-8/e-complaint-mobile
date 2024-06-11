class LoginResponse {
  final bool status;
  final String message;
  final UserData? data;
  final int statusCode;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
    required this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? 'No message provided',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      statusCode: json['statusCode'] ?? 0,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No name provided',
      email: json['email'] ?? 'No email provided',
      token: json['token'] ?? 'No token provided',
    );
  }
}
