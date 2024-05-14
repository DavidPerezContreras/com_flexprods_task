import 'package:test/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUserDetails(String token);
}
