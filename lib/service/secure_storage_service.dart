import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
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
    return User.fromJson(jsonDecode(userJson??""));
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
    return theme??"";//revisa estos null checks
    }

  Future<void> setCurrentTheme(String theme) async {
    await _storage.write(key: 'currentTheme', value: theme);
  }

  Future<void> deleteCurrentTheme() async {
    await _storage.delete(key: 'currentTheme');
  }

  Future<String> getCurrentSeedColor() async {
    String? color = await _storage.read(key: 'currentSeedColor');
    return color??"";
    }

  Future<void> setCurrentSeedColor(String color) async {
    await _storage.write(key: 'currentSeedColor', value: color);
  }

  Future<void> deleteCurrentSeedColor() async {
    await _storage.delete(key: 'currentSeedColor');
  }
}
