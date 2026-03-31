import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_decorations.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry padding;
  final double? blur;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.blur,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final effectiveBlur = blur ?? (isDark ? 15.0 : 30.0); // Ethereal Spec: 20-40px

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? AppDecorations.radiusMd),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: AppDecorations.getGlassDecoration(context, radius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
