import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:nested_navigation/data/auth/remote/exception/login_exceptions.dart';
import 'package:nested_navigation/data/auth/remote/exception/register_exceptions.dart';

class AuthRemoteImpl {
  AuthRemoteImpl();

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/auth/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginRequest.toJson()),
        )
        .timeout(Duration(seconds: 6));

    switch (response.statusCode) {
      case 200:
        return LoginResponse(token: jsonDecode(response.body)['token']);
      case 401:
        throw UnauthorizedLoginException();
      default:
        throw DefaultLoginException();
    }
  }

  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/auth/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerRequest.toJson()),
        )
        .timeout(Duration(seconds: 6));

    switch (response.statusCode) {
      case 200:
        return RegisterResponse(token: jsonDecode(response.body)['token']);
      case 401:
        throw UnauthorizedRegisterException();
      default:
        throw DefaultRegisterException();
    }
  }
}
