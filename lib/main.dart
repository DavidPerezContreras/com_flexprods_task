import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/describable_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:nested_navigation/presentation/pages/login/login_page.dart';
import 'package:nested_navigation/presentation/pages/splash_page/splash_page.dart';
import 'package:nested_navigation/provider/todo_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:nested_navigation/provider/bottom_navigation_provider.dart';
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
            ChangeNotifierProvider<BottomNavigationProvider>(
              create: (context) => BottomNavigationProvider(),
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
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final BottomNavigationProvider _bottomNavigationProvider;

  late final ThemeProvider _themeProvider;
  late final TodoProvider _todoProvider;

  late final VoidCallback setStateCallback;
  @override
  initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    _bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    setStateCallback = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavigationProvider.removeListener(setStateCallback);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _themeProvider.addListener(() {
        setState(() {});
      });

      _bottomNavigationProvider.addListener(setStateCallback);

      _authProvider.addListener(
        () {
          //_bottomNavigationProvider.init();
          ResourceState<User> userState = _authProvider.userState;

          switch (userState.status) {
            case Status.SUCCESS:
              //setState(() {
              //});
              Navigator.of(_topLevelNavigationProvider
                      .topLevelNavigation.currentContext!)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationPage(),
                ),
              );
              break;
            case Status.LOADING:
              Navigator.of(_topLevelNavigationProvider
                      .topLevelNavigation.currentContext!)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ),
              );
              break;
            case Status.ERROR:
              Navigator.of(_topLevelNavigationProvider
                      .topLevelNavigation.currentContext!)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              break;
            case Status.NONE:
              resetGlobalAppState();
              _todoProvider.init();
              _bottomNavigationProvider.init();
              Navigator.of(_topLevelNavigationProvider
                      .topLevelNavigation.currentContext!)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              break;
            default:
          }
        },
      );
      _authProvider.login("", "");
    });
  }

  void _showErrorMessage(DescribableError error, BuildContext context) async {
    String errorMessage = error.description;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _topLevelNavigationProvider.topLevelNavigation,
      theme: _themeProvider.getTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
