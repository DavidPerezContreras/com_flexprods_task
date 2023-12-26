import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/task_nav/sub_page/task_list_screen.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/second_screen.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/task_nav/task_navigator.dart';

class BottomNavigationProvider extends ChangeNotifier {
  late int _selectedIndex;
  late MaterialPage _activePage;
  late GlobalKey<NavigatorState> bottomNavigation;

  BottomNavigationProvider() {
    init();
  }

  void init() {
    _selectedIndex = 0;
    _activePage = const MaterialPage(child: TaskNavigator());
    bottomNavigation = GlobalKey<NavigatorState>();
  }

  int get selectedIndex => _selectedIndex;

  MaterialPage get activePage => _activePage;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    switch (newIndex) {
      case 0:
        _activePage = MaterialPage(child: TaskListScreen((newOffset) {
          onOffsetChanged(newOffset);
        }));
        break;
      case 1:
        _activePage = const MaterialPage(child: SecondScreen());
        break;
    }

    notifyListeners();
  }
}
