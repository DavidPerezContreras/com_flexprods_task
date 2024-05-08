import 'dart:convert';
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:http/http.dart' as http;

class UserRemoteImpl {
  

  Future<User> getCurrentUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 6));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return User.fromJson(responseBody);
    } else {
      throw Exception('Failed to get user details');
    }
  }
}
