import 'package:nested_navigation/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUserDetails(String token);
}
