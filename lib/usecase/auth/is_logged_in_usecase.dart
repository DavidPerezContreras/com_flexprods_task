import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class IsLoggedInUseCase {
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();

  Future<bool> get isLoggedIn async {
    final jwt = await _secureStorageService.getToken();
    return jwt != null && jwt.isNotEmpty;
  }
}
