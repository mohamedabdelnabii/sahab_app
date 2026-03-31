import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ----- Light Theme (Ethereal Atmosphere) -----
  static const Color lightPrimary = Color(0xFF006591);
  static const Color lightSkyTop = Color(0xFFE0F2FE);
  static const Color lightSkyBottom = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF7F9FB);
  static const Color lightSurfaceLow = Color(0xFFF2F4F6);
  static const Color lightSurfaceLowest = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF191C1E);
  static const Color lightLabel = Color(0xFF505F76);
  static const Color lightDescription = Color(0xFF3C4758); // on_surface_variant
  static const Color font22WhiteRegular = Color(0xFFE7EEEE);
  static const Color font14WhiteSemiBoldSpacing = Color(0xFFE7EEEE);
  // ----- Dark Theme (Existing) -----
  static const Color darkPrimary = Color(0xFF62B8FF);
  static const Color darkBgTop = Color(0xFF39537A);
  static const Color darkBgMid = Color(0xFF18192B);
  static const Color darkBgBottom = Color(0xFF0D0E19);
  static const Color darkSurface = Color(0xFF1C1B33);
  static const Color darkOnSurface = Colors.white;
  static const Color darkLabel = Color(0xFFEBEBF5);
  static const Color darkDescription = Color(0x99EBEBF5);

  // Common Colors
  static const Color transparent = Colors.transparent;
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Helper to get theme colors
  static bool isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

  static Color primary(BuildContext context) => isDark(context) ? darkPrimary : lightPrimary;
  static Color onSurface(BuildContext context) => isDark(context) ? darkOnSurface : lightOnSurface;
  static Color label(BuildContext context) => isDark(context) ? darkLabel : lightLabel;
  static Color description(BuildContext context) => isDark(context) ? darkDescription : lightDescription;
}
