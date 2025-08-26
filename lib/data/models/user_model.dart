// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String? name; // Optional
  final String? profileImageUrl; // Optional
  final String? role; // e.g., 'student', 'instructor', 'admin'
  final String? token; // The authentication token received from backend

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.profileImageUrl,
    this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'],
      role: json['role'],
      token: json['token'], // Important for session management
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'role': role,
      'token': token,
    };
  }
}