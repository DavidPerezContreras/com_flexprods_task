import 'package:dio/dio.dart';
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/domain/model/user.dart';

class UserRemoteImpl {
  Dio _dio;
  UserRemoteImpl(this._dio);

  Future<User> getCurrentUserDetails(String token) async {
    final response = await _dio.get(
      '$baseUrl/users',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    return User(id: response.data['id'], username: response.data['username']);
  }
}
