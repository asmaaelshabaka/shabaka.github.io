class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}
