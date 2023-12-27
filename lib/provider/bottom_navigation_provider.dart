import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_pages/todo_list_page.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_pages/settings_page.dart';

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
