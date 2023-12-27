// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> customYellowColor = {
  50: const Color.fromRGBO(255, 255, 0, .1),
  100: const Color.fromRGBO(255, 255, 0, .2),
  200: const Color.fromRGBO(255, 255, 0, .3),
  300: const Color.fromRGBO(255, 255, 0, .4),
  400: const Color.fromRGBO(255, 255, 0, .5),
  500: const Color.fromRGBO(255, 255, 0, .6),
  600: const Color.fromRGBO(255, 255, 0, .7),
  700: const Color.fromRGBO(255, 255, 0, .8),
  800: const Color.fromRGBO(255, 255, 0, .9),
  900: const Color.fromRGBO(255, 255, 0, 1),
};

MaterialColor customYellowMaterialColor =
    MaterialColor(0xFFFFEB3B, customYellowColor);
