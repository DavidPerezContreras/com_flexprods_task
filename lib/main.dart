import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_navigation.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<BottomNavigationProvider>(
      create: (context) => BottomNavigationProvider(),
      child: ChangeNotifierProvider<AuthNavigationProvider>(
        create: (context) => AuthNavigationProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthNavigation(),
    );
  }
}
