import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../di/service_locator.dart';
import '../../service/secure_storage_service.dart';

class IsLoggedInUseCase {
  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future<bool> get isLoggedIn async {
    final jwt = await _secureStorageService.getToken();
    return jwt != null && jwt.isNotEmpty;
  }
}
