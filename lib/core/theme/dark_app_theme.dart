import 'package:flutter/material.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';

import '../values/colors.dart';
import '../values/consts.dart';

final darkAppTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: VariantTheme.primary.color,
      onPrimary: Colors.white,
      secondary: VariantTheme.secondary.color,
      onSecondary: Colors.white,
      surface: darkBackgroundColor,
      onSurface: darkTextColor,
      background: darkBackgroundColor,
      onBackground: darkTextColor,
      error: VariantTheme.danger.color,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    primaryColor: VariantTheme.primary.color,
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    shadowColor: darkShadowColor,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        fillColor: darkTextColor.withOpacity(.1),
        hintStyle:
            TextStyle(fontSize: 14, color: darkTextColor.withOpacity(.5)),
        prefixIconColor: darkTextColor.withOpacity(.7),
        prefixStyle: TextStyle(
          color: darkTextColor.withOpacity(.5),
          fontSize: 16,
        ),
        floatingLabelStyle: TextStyle(height: 4, fontSize: 12),
        filled: true,
        errorStyle: TextStyle(
          color: VariantTheme.danger.color,
          fontSize: 14,
        ),
        constraints: BoxConstraints(
            minHeight: vSize, minWidth: hSize, maxWidth: hSize)));
