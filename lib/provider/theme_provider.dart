import 'package:flutter/material.dart';
import 'package:test/di/service_locator.dart';

import 'package:test/service/secure_storage_service.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode;
  Color seedColor;
  SecureStorageService secureStorageService = locator<SecureStorageService>();

  ThemeProvider({this.isDarkMode=true, this.seedColor = Colors.blue});

  ThemeData getTheme() => _getThemeData(isDarkMode, seedColor);

  setTheme({bool? isDarkMode, Color? color}) async {
    if (isDarkMode != null) {
      this.isDarkMode = isDarkMode;
      await secureStorageService.setCurrentTheme(isDarkMode ? 'dark' : 'light');
    }
    if (color != null) {
      seedColor = color;
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


}
