import 'package:get_it/get_it.dart';
import 'package:test/data/auth/remote/auth_remote_impl.dart';
import 'package:test/data/auth/auth_data_impl.dart';
import 'package:test/data/todo/remote/todo_remote_impl.dart';
import 'package:test/data/todo/todo_data_impl.dart';
import 'package:test/data/user/remote/user_remote_impl.dart';
import 'package:test/data/user/user_data_impl.dart';
import 'package:test/domain/repository/auth_repository.dart';
import 'package:test/domain/repository/todo_repository.dart';
import 'package:test/domain/repository/user_repository.dart';
import 'package:test/service/secure_storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<SecureStorageService>(SecureStorageService());
  locator.registerSingleton<AuthRepository>(AuthDataImpl(AuthRemoteImpl()));
  locator.registerSingleton<UserRepository>(UserDataImpl(UserRemoteImpl()));
  locator.registerSingleton<TodoRepository>(TodoDataImpl(TodoRemoteImpl()));
}
