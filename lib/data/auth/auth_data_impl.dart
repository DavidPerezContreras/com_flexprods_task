import 'package:test/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:test/data/auth/remote/DTO/auth_response_dto.dart';
import 'package:test/data/auth/remote/auth_remote_impl.dart';
import 'package:test/domain/repository/auth_repository.dart';

class AuthDataImpl implements AuthRepository {
  final AuthRemoteImpl _authRemoteImpl;
  AuthDataImpl(this._authRemoteImpl);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _authRemoteImpl.login(loginRequest);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    return await _authRemoteImpl.register(registerRequest);
  }
}
