import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:provider/provider.dart';

class AuthNavigation extends StatefulWidget {
  const AuthNavigation({super.key});

  @override
  State<AuthNavigation> createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNavigationProvider>(
      builder: (BuildContext context, authNavigationProvider, Widget? child) {
        return Scaffold(
          body: Navigator(
            key: authNavigationProvider.authNavigation,
            pages: [authNavigationProvider.activePage],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              return true;
            },
          ),
        );
      },
    );
  }
}
