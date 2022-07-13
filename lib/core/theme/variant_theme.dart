import 'dart:ui';

class VariantTheme {
  VariantTheme._();
  static const primary = VariantColorScheme(
      color: _VariantColors.primaryColor,
      shadowColor: _VariantColors.primaryShadowColor,
      onColor: _VariantColors.primaryOnColor);
  static const secondary = VariantColorScheme(
      color: _VariantColors.secondaryColor,
      shadowColor: _VariantColors.secondaryShadowColor,
      onColor: _VariantColors.secondaryOnColor);
  static const info = VariantColorScheme(
      color: _VariantColors.infoColor,
      shadowColor: _VariantColors.infoShadowColor,
      onColor: _VariantColors.infoOnColor);
  static const warning = VariantColorScheme(
      color: _VariantColors.warningColor,
      shadowColor: _VariantColors.warningShadowColor,
      onColor: _VariantColors.warningOnColor);
  static const danger = VariantColorScheme(
      color: _VariantColors.dangerColor,
      shadowColor: _VariantColors.dangerShadowColor,
      onColor: _VariantColors.dangerOnColor);
  static const success = VariantColorScheme(
      color: _VariantColors.successColor,
      shadowColor: _VariantColors.successShadowColor,
      onColor: _VariantColors.successOnColor);
  static const light = VariantColorScheme(
      color: _VariantColors.lightColor,
      shadowColor: _VariantColors.lightShadowColor,
      onColor: _VariantColors.lightOnColor);
  static const dark = VariantColorScheme(
      color: _VariantColors.darkColor,
      shadowColor: _VariantColors.darkShadowColor,
      onColor: _VariantColors.darkOnColor);
}

class VariantColorScheme {
  final Color color;
  final Color shadowColor;
  final Color onColor;

  const VariantColorScheme(
      {required this.color, required this.shadowColor, required this.onColor});
}

class _VariantColors {
  _VariantColors._();

  static const onColorLight = Color(0xFFF5F5F5);
  static const onColorDark = Color(0xFF353c48);

  static const primaryColor = Color(0xFF6777ef);
  static const primaryOnColor = onColorLight;
  static const primaryShadowColor = Color(0xFFacb5f6);

  static const secondaryColor = Color(0xFF9BA6F4);
  static const secondaryOnColor = onColorDark;
  static const secondaryShadowColor = Color(0xFFd6d9f7);

  static const infoColor = Color(0xFF3abaf4);
  static const infoOnColor = onColorLight;
  static const infoShadowColor = Color(0xFF82d3f8);

  static const warningColor = Color(0xFFffa426);
  static const warningOnColor = onColorLight;
  static const warningShadowColor = Color(0xFFffd966);

  static const dangerColor = Color(0xFFfc544b);
  static const dangerOnColor = onColorLight;
  static const dangerShadowColor = Color(0xFFfd9b96);

  static const successColor = Color(0xFF54ca68);
  static const successOnColor = Color(0xFFF5F5F5);
  static const successShadowColor = Color(0xFF8edc9c);

  static const lightColor = Color(0xFFc5cbd1);
  static const lightOnColor = onColorDark;
  static const lightShadowColor = Color(0xFFf0f1f5);

  static const darkColor = Color(0xFF191d21);
  static const darkOnColor = onColorLight;
  static const darkShadowColor = Color(0xFF728394);
}
