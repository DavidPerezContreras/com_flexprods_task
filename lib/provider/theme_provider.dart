import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode;

  ThemeProvider({required this.isDarkMode});

  getTheme() => isDarkMode ? darkTheme : lightTheme;

  setTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;

    notifyListeners();
  }
}
