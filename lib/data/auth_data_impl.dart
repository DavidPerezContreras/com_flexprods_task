import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';

class AuthDataImpl implements AuthRepository {
  @override
  Future<ResourceState<bool>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<ResourceState<bool>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<ResourceState<bool>> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
