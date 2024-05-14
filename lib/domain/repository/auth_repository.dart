import 'package:test/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:test/data/auth/remote/DTO/auth_response_dto.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<RegisterResponse> register(RegisterRequest registerRequest);
}
