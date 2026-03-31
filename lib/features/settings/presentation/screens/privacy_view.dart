import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';
import 'package:sahab/generated/l10n.dart';

class PrivacyView extends StatelessWidget {
  static const String routeName = '/privacy';

  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final onSurface = context.onSurfaceColor;
    final labelColor = context.labelColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          s.privacyTitle,
          style: context.font14PrimarySemiBoldSpacing,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.getMainGradient(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.privacyPolicy, style: context.font18PrimaryBold),
                        const SizedBox(height: 16),
                        Text(
                          s.privacyContent,
                          style: TextStyle(
                            color: onSurface.withValues(alpha: 0.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    s.copyright,
                    style: TextStyle(
                      color: labelColor.withValues(alpha: 0.24),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
