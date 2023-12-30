import 'package:flutter/material.dart';
import 'package:nested_navigation/data/auth/remote/DTO/auth_request_dto.dart';
import 'package:nested_navigation/data/auth/remote/error/login_errors.dart';
import 'package:nested_navigation/data/auth/remote/error/register_errors.dart';
import 'package:nested_navigation/data/auth/remote/exception/login_exceptions.dart';
import 'package:nested_navigation/data/auth/remote/exception/register_exceptions.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/usecase/auth/login_usercase.dart';
import 'package:nested_navigation/usecase/auth/logout_usecase.dart';
import 'package:nested_navigation/usecase/auth/register_usecase.dart';

class AuthProvider extends ChangeNotifier {
  late ResourceState<User> _userState;
  final LoginUseCase _loginUseCase = LoginUseCase();
  final RegisterUseCase _registerUseCase = RegisterUseCase();
  final LogoutUseCase _logoutUseCase = LogoutUseCase();

  AuthProvider() {
    init();
  }

  void init() {
    _userState = ResourceState.none();
  }

  ResourceState<User> get userState => _userState;

  Future<void> login(String username, String password) async {
    _userState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      User user = await _loginUseCase
          .login(LoginRequest(username: username, password: password));
      _userState = ResourceState.success(user);
    } on UnauthorizedLoginException {
      _userState = ResourceState.error(UnauthorizedLoginError());
    } catch (exception) {
      _userState = ResourceState.error(DefaultLoginError());
    }

    notifyListeners();
  }

  Future<void> register(String username, String password) async {
    _userState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      User user = await _registerUseCase
          .register(RegisterRequest(username: username, password: password));
      _userState = ResourceState.success(user);
    } on UnauthorizedRegisterException {
      _userState = ResourceState.error(UnauthorizedRegisterError());
    } catch (exception) {
      _userState = ResourceState.error(DefaultRegisterError());
    }

    notifyListeners();
  }

  void logout() {
    _userState = ResourceState.none();
    _logoutUseCase.logout();
  }
}
