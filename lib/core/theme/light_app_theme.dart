import 'package:flutter/material.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';

import '../values/colors.dart';
import '../values/consts.dart';

final lightAppTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: VariantTheme.primary.color,
      onPrimary: Colors.white,
      secondary: VariantTheme.secondary.color,
      onSecondary: Colors.white,
      surface: lightBackgroundColor,
      onSurface: lightTextColor,
      background: lightBackgroundColor,
      onBackground: lightTextColor,
      error: VariantTheme.danger.color,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    shadowColor: lightShadowColor,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        fillColor: lightTextColor.withOpacity(.1),
        hintStyle:
            TextStyle(fontSize: 14, color: lightTextColor.withOpacity(.5)),
        prefixIconColor: lightTextColor.withOpacity(.7),
        prefixStyle: TextStyle(
          color: lightTextColor.withOpacity(.5),
          fontSize: 16,
        ),
        errorStyle: TextStyle(
          color: VariantTheme.danger.color,
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(height: 4, fontSize: 12),
        filled: true,
        constraints: BoxConstraints(
            minHeight: vSize, minWidth: hSize, maxWidth: hSize)));
