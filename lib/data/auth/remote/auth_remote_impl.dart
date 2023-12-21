import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Add this line

class AuthRemoteImpl {
  Dio _dio = Dio();
  final storage = FlutterSecureStorage(); // Add this line

  //Allow self-signed certificate
  AuthRemoteImpl() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      return HttpClient()..badCertificateCallback = (cert, host, port) => true;
    };
  }

  Future<ResourceState<bool>> login() async {
    try {
      final response = await _dio.post(
        'https://10.0.2.2:8080/api/auth/login',
        data: {"username": "username1", "password": "password"},
      );

      if (response.statusCode == 200) {
        // Store the JWT token securely instead of printing it
        await storage.write(key: 'jwt_token', value: response.data['token']);
        return ResourceState.success(true);
      } else {
        return ResourceState.error();
      }
    } catch (e) {
      print(e);
      return ResourceState.error();
    }
  }
}
