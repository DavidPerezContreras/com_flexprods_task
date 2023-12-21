import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/sub_page/home_screen.dart';

class BottomNavigationProvider {
  int _selectedIndex = 0;

  var _activePage = [
    MaterialPage(child: HomeScreen((newOffset) {
      onOffsetChanged(newOffset);
    }))
  ];

  GlobalKey<NavigatorState> nestedNavigation = GlobalKey<NavigatorState>();

  int get selectedIndex => _selectedIndex;

  List<MaterialPage> get activePage => _activePage;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    //notifyListeners();
  }

  void navigate(MaterialPage newPage) {
    _activePage = [newPage];
    //notifyListeners();
  }
}
