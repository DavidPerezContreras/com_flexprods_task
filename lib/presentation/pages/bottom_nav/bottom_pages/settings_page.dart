import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/login/login_page.dart';
import 'package:nested_navigation/presentation/theme/color.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/theme_provider.dart';
import 'package:nested_navigation/provider/todo_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ThemeProvider _themeProvider;
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final TodoProvider _todoProvider;
  final double _tileTextSize = 20;

  late Color _selectedColor; // Default selected color is blue

  @override
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);

    _todoProvider = Provider.of<TodoProvider>(context, listen: false);

    _selectedColor = Color.fromRGBO(_themeProvider.seedColor.red,
        _themeProvider.seedColor.green, _themeProvider.seedColor.blue, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 100),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                height: 50,
                child: ListTile(
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                  trailing: Switch(
                    value: _themeProvider.isDarkMode,
                    onChanged: (newValue) {
                      _themeProvider.setTheme(isDarkMode: newValue);
                    },
                  ),
                ),
              ),
              Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: colors.map((color) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          side: BorderSide(
                            width: _selectedColor == color
                                ? 3.0
                                : 1.0, // Enhance border if selected
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            // This makes the button square
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        onPressed: () {
                          _themeProvider.setTheme(color: color);
                          _selectedColor = color;
                        },
                        child: const SizedBox.shrink(),
                      );
                    }).toList(),
                  )),
              const Spacer(),
              Container(
                color: Theme.of(context).colorScheme.errorContainer,
                height: 50,
                child: ListTile(
                  title: Text(
                    textAlign: TextAlign.center,
                    "Logout",
                    style: TextStyle(
                      fontSize: _tileTextSize,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                  onTap: () {
                    _authProvider.logout();
                    resetGlobalAppState();
                    _todoProvider.init();
                    Navigator.of(_topLevelNavigationProvider
                            .topLevelNavigation.currentContext!)
                        .pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
