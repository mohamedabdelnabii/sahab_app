import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_decorations.dart';

class WelcomeView extends StatelessWidget {
  static const String routeName = '/welcome-view';

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final onSurface = context.onSurfaceColor;
    final primary = context.primaryColor;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.getMainGradient(context),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                vGap(80.h),
                Text(
                  s.appTitle,
                  style: context.font16PrimaryMedium.copyWith(
                    fontSize: 30.sp,
                    color: onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                vGap(30.h),
                Image.asset(
                  Assets.imageWelcome,
                  width: 220.w,
                  height: 230.h,
                  fit: BoxFit.contain,
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: s.welcomeTo,
                        style: context.font18PrimaryBold.copyWith(
                          color: onSurface,
                          fontSize: 24.sp,
                        ),
                      ),
                      TextSpan(
                        text: s.appTitle,
                        style: context.font18PrimaryBold.copyWith(
                          fontSize: 24.sp,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),

                vGap(14.h),

                Text(
                  s.experienceAtmosphere,
                  textAlign: TextAlign.center,
                  style: context.font14GlassMedium.copyWith(
                    color: context.labelColor,
                    fontSize: 15.sp,
                    height: 1.5,
                  ),
                ),

                vGap(40.h),

                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: () {
                      context.push(BottomNavBarView.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                        hGap(6.w),
                        Text(
                          s.getStarted,
                          style: context.font16AccentBold.copyWith(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                vGap(35.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    rowTextWithIcon(
                      context: context,
                      icon: Icons.wb_sunny_rounded,
                      text: s.realtime,
                    ),
                    rowTextWithIcon(
                      context: context,
                      icon: Icons.water_drop_rounded,
                      text: s.precise,
                    ),
                    rowTextWithIcon(
                      context: context,
                      icon: Icons.navigation,
                      text: s.global,
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowTextWithIcon({
    required BuildContext context,
    required IconData icon,
    required String text,
  }) {
    final labelColor = context.labelColor;
    return Row(
      children: [
        Icon(icon, color: labelColor.withValues(alpha: 0.7), size: 18.sp),
        hGap(4.w),
        Text(
          text,
          style: context.font14ErrorMedium.copyWith(
            fontSize: 11.sp,
            color: labelColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
