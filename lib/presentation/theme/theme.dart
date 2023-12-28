import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.blue,
  ),
);
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.blue,
  ),
);

//Theme is loaded from json asset I created with https://appainter.dev/
Future<ThemeData> loadThemeData(String path) async {
  final jsonString = await rootBundle.loadString(path);
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
  return ThemeDecoder.decodeThemeData(jsonMap) ?? ThemeData.light();
}
