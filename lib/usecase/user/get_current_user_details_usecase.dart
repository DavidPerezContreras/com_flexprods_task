import 'package:test/di/service_locator.dart';
import 'package:test/domain/model/user.dart';
import 'package:test/domain/repository/user_repository.dart';
import 'package:test/service/secure_storage_service.dart';

class GetCurrentUserDetailsUseCase {
  final UserRepository _userRepository = locator<UserRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<User> getCurrentUserDetails() async {
    String? token = await _storageService.getToken();
    return await _userRepository.getCurrentUserDetails(token??"");
    }
}
