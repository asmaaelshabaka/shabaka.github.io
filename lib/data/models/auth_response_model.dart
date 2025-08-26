import 'user_model.dart'; // Import your UserModel

class AuthResponseModel {
  final String token; // The access token (e.g., JWT)
  final String? refreshToken; // Optional: For renewing the access token
  final DateTime? tokenExpiryDate; // Optional: When the token expires
  final UserModel user; // Connection: The details of the authenticated user
  final String? message; // Optional: A message from the server (e.g., "Login successful")

  AuthResponseModel({
    required this.token,
    this.refreshToken,
    this.tokenExpiryDate,
    required this.user,
    this.message,
  });

  // Factory constructor to create an AuthResponseModel from a JSON map
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
      // Assuming 'expiresIn' from API is in seconds, convert to DateTime
      tokenExpiryDate: json['expiresIn'] != null
          ? DateTime.now().add(Duration(seconds: json['expiresIn'] as int))
          : null,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>), // Parse nested User data
      message: json['message'] as String?,
    );
  }

  // Method to convert an AuthResponseModel instance to a JSON map
  // (Less common to send this back to API, but good for completeness/storage)
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'tokenExpiryDate': tokenExpiryDate?.toIso8601String(),
      'user': user.toJson(), // Convert nested User object to JSON
      'message': message,
    };
  }

  AuthResponseModel copyWith({
    String? token,
    String? refreshToken,
    DateTime? tokenExpiryDate,
    UserModel? user,
    String? message,
  }) {
    return AuthResponseModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenExpiryDate: tokenExpiryDate ?? this.tokenExpiryDate,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'AuthResponseModel(token: [hidden], user_id: ${user.id}, message: $message)';
  }
}