import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/provider/top_level_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/bottom_nav_page.dart';
import 'package:provider/provider.dart';

class TopLevelNavigation extends StatefulWidget {
  const TopLevelNavigation({super.key});

  @override
  State<TopLevelNavigation> createState() => _TopLevelNavigationState();
}

class _TopLevelNavigationState extends State<TopLevelNavigation> {
  late final TopLevelNavigationProvider _topLevelNavigationProvider;

  @override
  void initState() {
    super.initState();
    _topLevelNavigationProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _topLevelNavigationProvider.topLevelNavigation,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const BottomNavigationPage();
          },
        );
      },
    );
  }
}
