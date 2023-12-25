import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:nested_navigation/data/auth/remote/auth_remote_impl.dart';
import 'package:nested_navigation/data/auth/auth_data_impl.dart';
import 'package:nested_navigation/data/user/remote/user_remote_impl.dart';
import 'package:nested_navigation/data/user/user_data_impl.dart';
import 'package:nested_navigation/domain/repository/auth_repository.dart';
import 'package:nested_navigation/domain/repository/user_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';
import 'package:nested_navigation/usecase/auth/login_usercase.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  Dio dio = Dio();
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    return HttpClient()..badCertificateCallback = (cert, host, port) => true;
  };
  locator.registerSingleton<AuthRepository>(AuthDataImpl(AuthRemoteImpl(dio)));
  locator.registerSingleton<UserRepository>(UserDataImpl(UserRemoteImpl(dio)));
  locator.registerSingleton<SecureStorageService>(SecureStorageService());
}
