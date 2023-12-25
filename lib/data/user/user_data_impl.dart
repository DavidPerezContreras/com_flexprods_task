import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nested_navigation/data/auth/remote/auth_remote_impl.dart';
import 'package:nested_navigation/data/user/remote/user_remote_impl.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';

class UserDataImpl implements UserRepository {
  UserRemoteImpl _userRemoteImpl;
  UserDataImpl(this._userRemoteImpl);
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  Future<User> getCurrentUserDetails(String token) async {
    return _userRemoteImpl.getCurrentUserDetails(token);
  }
}
