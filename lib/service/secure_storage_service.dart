import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nested_navigation/domain/model/user.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: 'jwt');
  }

  Future<void> removeToken() async {
    await _storage.delete(key: 'jwt');
  }

  Future<User?> getCurrentUser() async {
    String? userJson = await _storage.read(key: 'currentUser');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }

  Future<void> setCurrentUser(User user) async {
    String userJson = jsonEncode(user.toJson());
    await _storage.write(key: 'currentUser', value: userJson);
  }

  Future<void> deleteCurrentUser() async {
    await _storage.delete(key: 'currentUser');
  }

  Future<String> getCurrentTheme() async {
    String? theme = await _storage.read(key: 'currentTheme');
    if (theme != null) {
      return theme;
    } else {
      await _storage.write(key: 'currentTheme', value: 'dark');
      return 'dark';
    }
  }

  Future<void> setCurrentTheme(String theme) async {
    await _storage.write(key: 'currentTheme', value: theme);
  }

  Future<void> deleteCurrentTheme() async {
    await _storage.delete(key: 'currentTheme');
  }
}
