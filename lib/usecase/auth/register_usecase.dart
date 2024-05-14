import 'package:test/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:test/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:test/di/service_locator.dart';
import 'package:test/domain/model/user.dart';
import 'package:test/domain/repository/auth_repository.dart';
import 'package:test/domain/repository/user_repository.dart';
import 'package:test/service/secure_storage_service.dart';

class RegisterUseCase {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();

  Future<User> register(RegisterRequest registerRequest) async {
    final RegisterResponse registerResponse =
        await _authRepository.register(registerRequest);
    await _secureStorageService.saveToken(registerResponse.token!);
    final user = await _userRepository
        .getCurrentUserDetails(await _secureStorageService.getToken() ?? "");
    return user;
  }
}
