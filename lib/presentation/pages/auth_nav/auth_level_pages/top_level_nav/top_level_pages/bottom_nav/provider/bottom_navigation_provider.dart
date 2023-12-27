import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/bottom_pages/home_page.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/bottom_pages/settings_page.dart';

class BottomNavigationProvider extends ChangeNotifier {
  late int _selectedIndex;
  late MaterialPage _activePage;
  late GlobalKey<NavigatorState> nestedNavigation;
  BottomNavigationProvider() {
    init();
  }

  void init() {
    _selectedIndex = 0;
    _activePage = MaterialPage(child: TodoListPage((newOffset) {
      onOffsetChanged(newOffset);
    }));
    nestedNavigation = GlobalKey<NavigatorState>();
  }

  int get selectedIndex => _selectedIndex;

  MaterialPage get activePage => _activePage;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    switch (newIndex) {
      case 0:
        _activePage = MaterialPage(child: TodoListPage((newOffset) {
          onOffsetChanged(newOffset);
        }));
        break;
      case 1:
        _activePage = const MaterialPage(child: SettingsPage());
        break;
    }

    notifyListeners();
  }
}
