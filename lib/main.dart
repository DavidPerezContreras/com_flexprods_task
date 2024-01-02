import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/presentation/pages/login/login_page.dart';
import 'package:nested_navigation/provider/todo_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
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
CURRENTLY IT ALLOWS ALL CERTIFICATES, ALLOWING MAN-IN-THE-MIDDLE ATTACKS  !!!!!!L*/

//Es problema del backend, que me den un certificado firmado por una CA authority y ya.
//Como yo he hecho el backend pues no quiero perder tiempo en eso :)

/*La otra opción aunque tampoco esa perfecta, sería comprobar el certificado manualmente.
*/

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
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
            ChangeNotifierProvider<TodoProvider>(
              create: (context) => TodoProvider(),
            ),
            ChangeNotifierProvider<TopLevelNavigationProvider>(
              create: (_) => TopLevelNavigationProvider(),
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(isDarkMode: true),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final TopLevelNavigationProvider _topLevelNavigationProvider;

  late final ThemeProvider _themeProvider;

  @override
  initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    _themeProvider.addListener(() {
      setState(() {});
    });
    //});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _topLevelNavigationProvider.topLevelNavigation,
      theme: _themeProvider.getTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
