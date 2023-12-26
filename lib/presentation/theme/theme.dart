import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

late final ThemeData lightTheme;
late final ThemeData darkTheme;

//Theme is loaded from json asset I created with https://appainter.dev/
Future<ThemeData> loadThemeData(String path) async {
  final jsonString = await rootBundle.loadString(path);
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
  return ThemeDecoder.decodeThemeData(jsonMap) ?? ThemeData.light();
}
