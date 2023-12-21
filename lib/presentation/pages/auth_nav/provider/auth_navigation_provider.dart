import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/content_page.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/login/login_page.dart';

class AuthNavigationProvider extends ChangeNotifier {
  late List<MaterialPage> _pages;
  late MaterialPage _activePage;
  GlobalKey<NavigatorState> authNavigation = GlobalKey<NavigatorState>();

  AuthNavigationProvider() {
    init();
  }

  void init() {
    _pages = [
      const MaterialPage(child: LoginPage()),
      const MaterialPage(child: ContentPage())
    ];
    _activePage = _pages[0];
  }

  MaterialPage get activePage => _activePage;

  void logout() {
    init();
    resetGlobalAppState(); //handle global state
    notifyListeners();
  }

  void login() {
    //make http request.
    navigate(MaterialPage(child: ContentPage()));
    //if correct, call navigate
  }

  void navigate(MaterialPage materialPage) {
    _activePage = materialPage;
    notifyListeners();
  }
}
