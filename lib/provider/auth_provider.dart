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
  late ResourceState<User> _loginState;
  late ResourceState<User> _registerState;
  final LoginUseCase _loginUseCase = LoginUseCase();
  final RegisterUseCase _registerUseCase = RegisterUseCase();
  final LogoutUseCase _logoutUseCase = LogoutUseCase();

  AuthProvider() {
    init();
  }

  void init() {
    _loginState = ResourceState.none();
    _registerState = ResourceState.none();
  }

  ResourceState<User> get loginState => _loginState;
  ResourceState<User> get registerState => _registerState;

  Future<void> login(String username, String password) async {
    _loginState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      User user = await _loginUseCase
          .login(LoginRequest(username: username, password: password));
      _loginState = ResourceState.success(user);
    } on UnauthorizedLoginException {
      _loginState = ResourceState.error(UnauthorizedLoginError());
    } catch (exception) {
      _loginState = ResourceState.error(DefaultLoginError());
    }

    notifyListeners();
  }

  Future<void> fastLogin(String username, String password) async {
    _loginState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      User user = await _loginUseCase
          .login(LoginRequest(username: username, password: password));
      _loginState = ResourceState.success(user);
      notifyListeners();
      return;
    } on UnauthorizedLoginException {
      //_loginState = ResourceState.error(UnauthorizedLoginError());
    } catch (exception) {
      //_loginState = ResourceState.error(DefaultLoginError());
    }
    _loginState = ResourceState.none();
    notifyListeners();
  }

  Future<void> register(String username, String password) async {
    _registerState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      User user = await _registerUseCase
          .register(RegisterRequest(username: username, password: password));
      _registerState = ResourceState.success(user);
    } on UnauthorizedRegisterException {
      _registerState = ResourceState.error(UnauthorizedRegisterError());
    } catch (exception) {
      _registerState = ResourceState.error(DefaultRegisterError());
    }

    notifyListeners();
  }

  void logout() {
    init();
    _logoutUseCase.logout();
    notifyListeners();
  }
}
