import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_navigation_page.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => BottomNavigationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationPage(),
    );
  }
}
