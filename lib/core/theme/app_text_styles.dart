import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab/core/helpers/app_constants.dart';
import '../helpers/font_weight_helper.dart';
import 'app_colors.dart';

class ChangaTextStyle extends TextStyle {
  const ChangaTextStyle({
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.letterSpacing,
    super.height,
    super.decoration,
  }) : super(fontFamily: AppConstants.fontFamily);
}

class AppTextStyles {
  const AppTextStyles._();

  static Color _primaryColor(BuildContext context) => AppColors.onSurface(context);
  static Color _secondaryColor(BuildContext context) => AppColors.label(context);

  static TextStyle font24PrimaryBold(BuildContext context) => ChangaTextStyle(
    fontSize: 24.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font20PrimaryBold(BuildContext context) => ChangaTextStyle(
    fontSize: 20.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font18PrimaryBold(BuildContext context) => ChangaTextStyle(
    fontSize: 18.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font16PrimaryMedium(BuildContext context) => ChangaTextStyle(
    fontSize: 16.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font14PrimaryMedium(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font14SecondaryRegular(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: _secondaryColor(context),
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font12SecondaryMedium(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: _secondaryColor(context),
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font16AccentBold(BuildContext context) => ChangaTextStyle(
    fontSize: 16.sp,
    color: AppColors.primary(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font14AccentBold(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: AppColors.primary(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font12AccentBold(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: AppColors.primary(context),
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font14GlassMedium(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: AppColors.description(context),
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font12GlassRegular(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: AppColors.description(context),
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font100PrimaryExtraLight(BuildContext context) => ChangaTextStyle(
    fontSize: 100.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.extraLight,
    height: 1.0,
  );

  static TextStyle font22WhiteRegular(BuildContext context) =>  ChangaTextStyle(
    fontSize: 22.sp,
    color: AppColors.font22WhiteRegular,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font14WhiteSemiBoldSpacing(BuildContext context) =>  ChangaTextStyle(
    fontSize: 14.sp,
    color: AppColors.font14WhiteSemiBoldSpacing,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font14PrimarySemiBoldSpacing(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.semiBold,
    letterSpacing: 4,
  );

  static TextStyle font12Primary54MediumSpacing(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: _secondaryColor(context).withValues(alpha: 0.54),
    fontWeight: FontWeightHelper.medium,
    letterSpacing: 0.5,
  );

  static TextStyle font12Primary70Medium(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: _primaryColor(context).withValues(alpha: 0.7),
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font24PrimaryLight(BuildContext context) => ChangaTextStyle(
    fontSize: 24.sp,
    color: _primaryColor(context),
    fontWeight: FontWeightHelper.light,
  );

  static TextStyle font14Primary70Spacing(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: _primaryColor(context).withValues(alpha: 0.7),
    fontWeight: FontWeightHelper.regular,
    letterSpacing: 4,
  );

  static TextStyle font12Primary60Regular(BuildContext context) => ChangaTextStyle(
    fontSize: 12.sp,
    color: _primaryColor(context).withValues(alpha: 0.6),
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font14ErrorMedium(BuildContext context) => ChangaTextStyle(
    fontSize: 14.sp,
    color: AppColors.error,
    fontWeight: FontWeightHelper.medium,
  );
}
