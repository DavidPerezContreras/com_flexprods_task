import 'dart:io';
import 'package:dio/dio.dart';

import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_response_dto.dart';

class AuthRemoteImpl {
  final Dio _dio;

  AuthRemoteImpl(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '$baseUrl/auth/login',
      data: {"username": request.username, "password": request.password},
    );

    return LoginResponse(token: response.data['token']);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      '$baseUrl/auth/register',
      data: {"username": request.username, "password": request.password},
    );

    return RegisterResponse(token: response.data['token']);
  }
}
