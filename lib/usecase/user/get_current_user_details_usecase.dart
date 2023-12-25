import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class GetCurrentUserDetailsUsecase {
  final UserRepository _userRepository = locator<UserRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<User> getCurrentUserDetailsUsecase() async {
    String? token = await _storageService.getToken();
    if (token != null) {
      return _userRepository.getCurrentUserDetails(token);
    } else {
      throw Exception('No token found');
    }
  }
}
