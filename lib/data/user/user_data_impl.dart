import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nested_navigation/data/user/remote/user_remote_impl.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';

import '../../service/secure_storage_service.dart';

class UserDataImpl implements UserRepository {
  final UserRemoteImpl _userRemoteImpl;
  UserDataImpl(this._userRemoteImpl);


  @override
  Future<User> getCurrentUserDetails(String token) async {
    return _userRemoteImpl.getCurrentUserDetails(token);
  }
}
