import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test/di/service_locator.dart';
import 'package:test/presentation/pages/login/login_page.dart';
import 'package:test/provider/todo_provider.dart';
import 'package:test/provider/top_level_navigation_provider.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/theme_provider.dart';
import 'package:test/service/secure_storage_service.dart';

class ThemeSettings{
  ThemeSettings({this.isDarkMode=true, required this.seedColor});
  bool isDarkMode;
  Color seedColor;
}

  Future<ThemeSettings> loadThemeFromStorage(SecureStorageService secureStorageService) async {
    String theme = await secureStorageService.getCurrentTheme();
    String colorHex = await secureStorageService.getCurrentSeedColor();

    ThemeSettings settings=ThemeSettings(isDarkMode: theme=="dark",seedColor: Color(int.parse(colorHex, radix: 16)));


    return settings;
  }

Future<void> main() async {
  //HttpOverrides.global = MyHttpOverrides();
  setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
  SecureStorageService secureStorageService = locator<SecureStorageService>();

  ThemeSettings? themeSettings;

try {
  // Parsing operation causing the exception
  themeSettings=await loadThemeFromStorage(secureStorageService);
} on FormatException catch (e) {
  // Handle the format exception
  print('Error loading theme: ${e.message}. Using default theme.');
  // Load default theme or handle the error in some appropriate way
  themeSettings=ThemeSettings(seedColor: Colors.black,isDarkMode: true);
}




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
              create: (_) => ThemeProvider(isDarkMode: themeSettings!.isDarkMode,seedColor: themeSettings.seedColor),
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
