import 'dart:convert';
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:http/http.dart' as http;

class UserRemoteImpl {
  UserRemoteImpl();

  Future<User> getCurrentUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return User(id: responseBody['id'], username: responseBody['username']);
    } else {
      throw Exception('Failed to get user details');
    }
  }
}
