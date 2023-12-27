import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/login/login_page.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_navigation.dart';

class AuthNavigationProvider extends ChangeNotifier {
  late MaterialPage _activePage;
  late GlobalKey<NavigatorState> authNavigation;

  AuthNavigationProvider() {
    init();
  }

  void init() {
    authNavigation = GlobalKey<NavigatorState>();
    _activePage = const MaterialPage(child: LoginPage());
  }

  MaterialPage get activePage => _activePage;

  void logout() {
    init();
    resetGlobalAppState(); //handle global state
    notifyListeners();
  }

  void login() {
    //make http request.
    navigate(const MaterialPage(child: TopLevelNavigation()));
    //if correct, call navigate
  }

  void navigate(MaterialPage materialPage) {
    _activePage = materialPage;
    notifyListeners();
  }
}
