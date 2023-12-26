import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> customYellowColor = {
  50: Color.fromRGBO(255, 255, 0, .1),
  100: Color.fromRGBO(255, 255, 0, .2),
  200: Color.fromRGBO(255, 255, 0, .3),
  300: Color.fromRGBO(255, 255, 0, .4),
  400: Color.fromRGBO(255, 255, 0, .5),
  500: Color.fromRGBO(255, 255, 0, .6),
  600: Color.fromRGBO(255, 255, 0, .7),
  700: Color.fromRGBO(255, 255, 0, .8),
  800: Color.fromRGBO(255, 255, 0, .9),
  900: Color.fromRGBO(255, 255, 0, 1),
};

MaterialColor customYellowMaterialColor =
    MaterialColor(0xFFFFEB3B, customYellowColor);
