import 'package:flutter/material.dart';

class TopLevelNavigationProvider extends ChangeNotifier {
  late GlobalKey<NavigatorState> topLevelNavigation;

  TopLevelNavigationProvider() {
    init();
  }

  void init() {
    topLevelNavigation = GlobalKey<NavigatorState>();
  }
}
