import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_navigation/presentation/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

  getTheme() => isLightTheme ? lightTheme : darkTheme;

  setTheme(bool isLightTheme) {
    this.isLightTheme = isLightTheme;

    notifyListeners();
  }
}

Future<ThemeData> initializeThemeData() async {
  String jsonData = await rootBundle.loadString('assets/theme.json');
  Map<String, dynamic> data = jsonDecode(jsonData);

  return ThemeData(
    // Add your theme data here
    primaryColor: Color(int.parse(data['primaryColor'])),
    // ...
  );
}
