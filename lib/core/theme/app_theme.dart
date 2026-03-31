import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import '../helpers/app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightSurface,
      fontFamily: AppConstants.fontFamily,
      textTheme: _getTextTheme(context, Brightness.light),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkSurface,
      fontFamily: AppConstants.fontFamily,
      textTheme: _getTextTheme(context, Brightness.dark),
    );
  }

  static TextTheme _getTextTheme(BuildContext context, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final color = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    
    return TextTheme(
      displayLarge: AppTextStyles.font24PrimaryBold(context).copyWith(color: color),
      headlineMedium: AppTextStyles.font18PrimaryBold(context).copyWith(color: color),
      titleMedium: AppTextStyles.font16PrimaryMedium(context).copyWith(color: color),
      bodyLarge: AppTextStyles.font14PrimaryMedium(context).copyWith(color: color),
      bodyMedium: AppTextStyles.font14SecondaryRegular(context),
    );
  }
}
