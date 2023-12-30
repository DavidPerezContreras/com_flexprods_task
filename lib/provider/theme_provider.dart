import 'package:flutter/material.dart';
import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/presentation/theme/theme.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode;
  SecureStorageService secureStorageService = locator<SecureStorageService>();

  ThemeProvider({required this.isDarkMode}) {
    loadThemeFromStorage();
  }

  getTheme() => isDarkMode ? darkTheme : lightTheme;

  setTheme(bool isDarkMode) async {
    this.isDarkMode = isDarkMode;
    await secureStorageService.setCurrentTheme(isDarkMode ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> loadThemeFromStorage() async {
    String theme = await secureStorageService.getCurrentTheme();
    if (theme == 'dark') {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    notifyListeners();
  }
}
