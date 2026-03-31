import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static BoxDecoration getMainGradient(BuildContext context) {
    final isDark = AppColors.isDark(context);
    if (isDark) {
      return const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4, 1.0],
          colors: [
            AppColors.darkBgTop,
            AppColors.darkBgMid,
            AppColors.darkBgBottom,
          ],
        ),
      );
    } else {
      return const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.lightSkyTop,
            AppColors.lightSkyBottom,
          ],
        ),
      );
    }
  }

  static const double radiusLg = 32.0;
  static const double radiusMd = 24.0;

  static BoxDecoration getGlassDecoration(BuildContext context, {double? radius}) {
    final isDark = AppColors.isDark(context);
    return BoxDecoration(
      color: isDark 
          ? Colors.white.withValues(alpha: 0.1) 
          : AppColors.lightSurfaceLowest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(radius ?? radiusMd),
      border: Border.all(
        color: isDark 
            ? Colors.white.withValues(alpha: 0.1) 
            : AppColors.lightOnSurface.withValues(alpha: 0.05),
      ),
    );
  }

  // Legacy static decoration for initial refactor safety
  static const BoxDecoration mainGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.4, 1.0],
      colors: [
        AppColors.darkBgTop,
        AppColors.darkBgMid,
        AppColors.darkBgBottom,
      ],
    ),
  );
}
