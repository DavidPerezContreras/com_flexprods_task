import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_navigation.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/provider/bottom_navigation_provider.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  setupLocator();
  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      builder: (context, child) =>
          ChangeNotifierProvider<AuthNavigationProvider>(
        create: (context) => AuthNavigationProvider(
            /*anotherProvider: context.watch<AnotherProvider>()*/),
        builder: (context, child) =>
            ChangeNotifierProvider<BottomNavigationProvider>(
          create: (context) => BottomNavigationProvider(),
          builder: (context, child) => const MyApp(),
        ),
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
