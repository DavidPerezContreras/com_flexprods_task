import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/task_nav/sub_page/task_list_screen.dart';

class TaskNavigationProvider extends ChangeNotifier {
  late MaterialPage _activePage;
  late GlobalKey<NavigatorState> taskNavigation;

  TaskNavigationProvider() {
    init();
  }

  void init() {
    taskNavigation = GlobalKey<NavigatorState>();
    _activePage = MaterialPage(child: TaskListScreen((newOffset) {
      onOffsetChanged(newOffset);
    }));
  }

  MaterialPage get activePage => _activePage;

  void navigate(MaterialPage materialPage) {
    _activePage = materialPage;
    notifyListeners();
  }
}
