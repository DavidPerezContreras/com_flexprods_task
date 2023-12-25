import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _authRepository = locator<AuthRepository>();

  Future<RegisterResponse> register(RegisterRequest request) async {
    return _authRepository.register(request);
  }
}
