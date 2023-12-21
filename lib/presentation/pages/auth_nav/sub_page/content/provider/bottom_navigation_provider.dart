import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/home_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {
  late int _selectedIndex;
  late List<MaterialPage> _activePage;
  BottomNavigationProvider() {
    init();
  }

  void init() {
    _selectedIndex = 0;
    _activePage = [
      MaterialPage(child: HomeScreen((newOffset) {
        onOffsetChanged(newOffset);
      }))
    ];
  }

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
