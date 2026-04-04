import 'package:flutter/material.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_text_styles.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension ThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Colors
  Color get primaryColor => AppColors.primary(this);
  Color get onSurfaceColor => AppColors.onSurface(this);
  Color get labelColor => AppColors.label(this);
  Color get descriptionColor => AppColors.description(this);

  // Typography
  TextStyle get font24PrimaryBold => AppTextStyles.font24PrimaryBold(this);
  TextStyle get font20PrimaryBold => AppTextStyles.font20PrimaryBold(this);
  TextStyle get font18PrimaryBold => AppTextStyles.font18PrimaryBold(this);

  TextStyle get font16PrimaryMedium => AppTextStyles.font16PrimaryMedium(this);
  TextStyle get font14PrimaryMedium => AppTextStyles.font14PrimaryMedium(this);

  TextStyle get font14SecondaryRegular =>
      AppTextStyles.font14SecondaryRegular(this);
  TextStyle get font12SecondaryMedium =>
      AppTextStyles.font12SecondaryMedium(this);

  TextStyle get font16AccentBold => AppTextStyles.font16AccentBold(this);
  TextStyle get font14AccentBold => AppTextStyles.font14AccentBold(this);
  TextStyle get font12AccentBold => AppTextStyles.font12AccentBold(this);

  TextStyle get font14GlassMedium => AppTextStyles.font14GlassMedium(this);
  TextStyle get font12GlassRegular => AppTextStyles.font12GlassRegular(this);

  TextStyle get font100PrimaryExtraLight =>
      AppTextStyles.font100PrimaryExtraLight(this);

  TextStyle get font14PrimarySemiBoldSpacing =>
      AppTextStyles.font14PrimarySemiBoldSpacing(this);

  TextStyle get font12Primary54MediumSpacing =>
      AppTextStyles.font12Primary54MediumSpacing(this);

  TextStyle get font12Primary70Medium =>
      AppTextStyles.font12Primary70Medium(this);

  TextStyle get font24PrimaryLight => AppTextStyles.font24PrimaryLight(this);

  TextStyle get font14Primary70Spacing =>
      AppTextStyles.font14Primary70Spacing(this);

  TextStyle get font12Primary60Regular =>
      AppTextStyles.font12Primary60Regular(this);

  TextStyle get font14ErrorMedium => AppTextStyles.font14ErrorMedium(this);
}
