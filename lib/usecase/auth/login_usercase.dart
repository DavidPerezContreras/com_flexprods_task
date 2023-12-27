import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class LoginUsecase {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future<User> login(LoginRequest request) async {
    final response = await _authRepository.login(request);
    await _secureStorageService.saveToken(response.token!);
    final user = await _userRepository
        .getCurrentUserDetails(await _secureStorageService.getToken() ?? "");
    return user;
  }
}
