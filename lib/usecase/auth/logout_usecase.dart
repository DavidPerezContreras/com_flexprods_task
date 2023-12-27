
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class LogoutUseCase {
  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future<void> logout() async {
    await _secureStorageService.removeToken();
  }
}