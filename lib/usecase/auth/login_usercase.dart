import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class LoginUsecase {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<void> login(LoginRequest request) async {
    final response = await _authRepository.login(request);
    if (response.token != null) {
      await _storageService.saveToken(response.token!);
    }
  }
}
