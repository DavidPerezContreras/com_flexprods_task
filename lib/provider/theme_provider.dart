import 'package:flutter/material.dart';
import 'package:nested_navigation/di/service_locator.dart';

import 'package:nested_navigation/service/secure_storage_service.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode;
  Color seedColor;
  SecureStorageService secureStorageService = locator<SecureStorageService>();

  ThemeProvider({required this.isDarkMode, this.seedColor = Colors.blue}) {
    loadThemeFromStorage();
  }

  ThemeData getTheme() => _getThemeData(isDarkMode, seedColor);

  setTheme({bool? isDarkMode, Color? color}) async {
    if (isDarkMode != null) {
      this.isDarkMode = isDarkMode;
      await secureStorageService.setCurrentTheme(isDarkMode ? 'dark' : 'light');
    }
    if (color != null) {
      this.seedColor = color;
      await secureStorageService
          .setCurrentSeedColor(color.value.toRadixString(16));
    }
    notifyListeners();
  }

  ThemeData _getThemeData(bool isDarkMode, Color seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        seedColor: seedColor,
      ),
    );
  }

  Future<void> loadThemeFromStorage() async {
    String theme = await secureStorageService.getCurrentTheme();
    String colorHex = await secureStorageService.getCurrentSeedColor();
    isDarkMode = theme == 'dark';
    seedColor = Color(int.parse(colorHex, radix: 16));
    notifyListeners();
  }
}
