import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class LoginUseCase {
  final UserRepository _userRepository = locator<UserRepository>();
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();

  Future<User> login(LoginRequest loginRequest) async {
    String? token = await _secureStorageService.getToken();
    // If token exists, get user details directly
    final user = await _userRepository.getCurrentUserDetails(token??"");
    return user;
    }
}
