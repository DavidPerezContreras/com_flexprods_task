import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/task_nav/provider/task_navigation_provider.dart';
import 'package:provider/provider.dart';

class TaskNavigator extends StatefulWidget {
  const TaskNavigator({super.key});

  @override
  State<TaskNavigator> createState() => _TaskNavigatorState();
}

class _TaskNavigatorState extends State<TaskNavigator> {
  late final TaskNavigationProvider _taskNavigationProvider;

  @override
  void initState() {
    super.initState();
    _taskNavigationProvider =
        Provider.of<TaskNavigationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _taskNavigationProvider.taskNavigation,
      pages: [_taskNavigationProvider.activePage],
    );
  }
}
