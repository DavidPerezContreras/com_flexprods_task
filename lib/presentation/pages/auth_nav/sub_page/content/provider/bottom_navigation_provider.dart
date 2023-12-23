import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/home_screen.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/second_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {
  late int _selectedIndex;
  late MaterialPage _activePage;
  late GlobalKey<NavigatorState> nestedNavigation;
  BottomNavigationProvider() {
    init();
  }

  void init() {
    _selectedIndex = 0;
    _activePage = MaterialPage(child: HomeScreen((newOffset) {
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
        _activePage = MaterialPage(child: HomeScreen((newOffset) {
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
