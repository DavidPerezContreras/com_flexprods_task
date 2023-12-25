import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/error/auth_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/usecase/auth/login_usercase.dart';
import 'package:nested_navigation/usecase/auth/register_usecase.dart';
import 'package:nested_navigation/usecase/user/get_current_user_details_usecase.dart';

class AuthProvider extends ChangeNotifier {
  late ResourceState<User> _userState;
  final LoginUsecase _loginUseCase = LoginUsecase();
  final RegisterUsecase _registerUseCase = RegisterUsecase();
  final GetCurrentUserDetailsUsecase _getCurrentUserDetailsUseCase =
      GetCurrentUserDetailsUsecase();

  AuthProvider() {
    init();
  }

  void init() {
    _userState = ResourceState.none();
  }

  ResourceState<User> get userState => _userState;

  void login(String username, String password) async {
    _userState = ResourceState.loading();
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));

    try {
      User user = await _loginUseCase
          .login(LoginRequest(username: username, password: password));
      _userState = ResourceState.success(user);
    } on DioException catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode!;
        print('Status code: $statusCode');
        if (statusCode == 401) {
          _userState = ResourceState.error(UnauthorizedError());
        } else {
          _userState = ResourceState.error(DefaultError());
        }
      }
    } catch (exception) {
      _userState = ResourceState.error(DefaultError());
    }

    notifyListeners();
  }

  void logout() {
    _userState = ResourceState.none();
    notifyListeners();
  }
}
