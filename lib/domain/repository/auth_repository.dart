import 'package:nested_navigation/domain/model/resource_state.dart';

abstract class AuthRepository {
  Future<ResourceState<bool>> login();
  Future<ResourceState<bool>> register();
}
