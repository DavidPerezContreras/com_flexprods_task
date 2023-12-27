import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';


class RegisterUseCase {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future<RegisterResponse> register(RegisterRequest request) async {
    throw UnimplementedError();
    //return _authRepository.register(request);
  }
}
