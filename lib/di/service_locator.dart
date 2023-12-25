import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:nested_navigation/data/auth/remote/auth_remote_impl.dart';
import 'package:nested_navigation/data/auth/auth_data_impl.dart';
import 'package:nested_navigation/data/user/remote/user_remote_impl.dart';
import 'package:nested_navigation/data/user/user_data_impl.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthRepository>(AuthDataImpl(AuthRemoteImpl()));
  locator.registerSingleton<UserRepository>(UserDataImpl(UserRemoteImpl()));
  locator.registerSingleton<SecureStorageService>(SecureStorageService());
}
