class ChatbotMessage {
  final int id;
  final User user;
  final String userMessage;
  final String botResponse;
  final String createdAt;

  ChatbotMessage({
    required this.id,
    required this.user,
    required this.userMessage,
    required this.botResponse,
    required this.createdAt,
  });

  factory ChatbotMessage.fromJson(Map<String, dynamic> json) {
    return ChatbotMessage(
      id: json['data']['id'],
      user: User.fromJson(json['data']['user']),
      userMessage: json['data']['user_message'],
      botResponse: json['data']['bot_response'],
      createdAt: json['data']['created_at'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String telephoneNumber;
  final String profilePhoto;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.telephoneNumber,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephoneNumber: json['telephone_number'],
      profilePhoto: json['profile_photo'],
    );
  }
}
