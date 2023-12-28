class LoginRequest {
  LoginRequest({required this.username, required this.password});

  String username;
  String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class RegisterRequest {
  RegisterRequest({required this.username, required this.password});

  String username;
  String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
