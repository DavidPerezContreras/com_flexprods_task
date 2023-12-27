import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_navigation.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/provider/top_level_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/provider/bottom_navigation_provider.dart';
import 'package:nested_navigation/presentation/theme/theme.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
} /*TODO SECURITY RIST!!! YOU MUST VALIDATE THE CERTIFICATE BINARY MANUALLY!!
CURRENTLY IT ALLOWS ALL CERTIFICATES, LEADING TO MAN-IN-THE-MIDDLE ATTACKS */

//Es problema del backend, que me den un certificado firmado por una CA authority y ya.
//Como yo he hecho el backend pues no quiero perder tiempo en eso :)

/*La otra opción aunque tampoco esa perfecta, sería comprobar el certificado manualmente.
*/

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  lightTheme = await loadThemeData('assets/theme/light_theme.json');
  darkTheme = await loadThemeData('assets/theme/dark_theme.json');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider<AuthNavigationProvider>(
              create: (context) => AuthNavigationProvider(),
            ),
            ChangeNotifierProvider<TopLevelNavigationProvider>(
              create: (_) => TopLevelNavigationProvider(),
            ),
            ChangeNotifierProvider<BottomNavigationProvider>(
              create: (context) => BottomNavigationProvider(),
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(isLightTheme: false),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.getTheme(),
      debugShowCheckedModeBanner: false,
      home: const AuthNavigation(),
    );
  }
}
