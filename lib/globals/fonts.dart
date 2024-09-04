import 'package:flutter/material.dart';

double _fontSizeMultiplier = 1;
setFontSizeMultiplier(double multiplier) {
  _fontSizeMultiplier = multiplier;
}

class Fonts {
  static poppins({
    Color color = Colors.white,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSizeMultiplier,
  }) =>
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
        fontSize: fontSize * (fontSizeMultiplier ?? _fontSizeMultiplier),
        color: color,
      );
  static inter({
    Color color = Colors.white,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSizeMultiplier,
  }) =>
      TextStyle(
        fontFamily: 'Inter',
        fontWeight: fontWeight,
        fontSize: fontSize * (fontSizeMultiplier ?? _fontSizeMultiplier),
        color: color,
      );
}
