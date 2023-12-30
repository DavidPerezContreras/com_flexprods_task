import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/login/login_page.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/bottom_navigation_provider.dart';
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
  late final BottomNavigationProvider _bottomNavigationProvider;
  late final TodoProvider _todoProvider;
  final double _tileTextSize = 20;

  Color _selectedColor = Colors.blue; // Default selected color is blue

  List<Color> _colors = [
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.orange
  ];

  @override
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);

    _bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);

    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                height: 50,
                child: ListTile(
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                    children: _colors.map((color) {
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
                          setState() {
                            _selectedColor = color;
                          }

                          _themeProvider.setTheme(color: color);
                        },
                        child: SizedBox.shrink(),
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
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  onTap: () {
                    _authProvider.logout();
                    _todoProvider.init();
                    _bottomNavigationProvider.init();
                    resetGlobalAppState();
                    Navigator.of(_topLevelNavigationProvider
                            .topLevelNavigation.currentState!.context)
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
