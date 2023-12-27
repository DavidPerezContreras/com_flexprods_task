import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:nested_navigation/data/auth/remote/exception/login_exceptions.dart';

class AuthRemoteImpl {
  AuthRemoteImpl();

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"username": request.username, "password": request.password}),
    );

    switch (response.statusCode) {
      case 200:
        return LoginResponse(token: jsonDecode(response.body)['token']);
      case 401:
        throw UnauthorizedLoginException();
      default:
        throw DefaultLoginException();
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"username": request.username, "password": request.password}),
    );

    switch (response.statusCode) {
      case 200:
        return RegisterResponse(token: jsonDecode(response.body)['token']);
      case 401:
        throw UnauthorizedLoginException();
      default:
        throw DefaultLoginException();
    }
  }
}
