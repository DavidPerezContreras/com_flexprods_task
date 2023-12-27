import '../../di/service_locator.dart';
import '../../service/secure_storage_service.dart';

class LogoutUseCase {
  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future<void> logout() async {
    await _secureStorageService.removeToken();
  }
}