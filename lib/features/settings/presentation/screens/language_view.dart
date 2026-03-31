import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/cubit/language/language_cubit.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';
import 'package:sahab/generated/l10n.dart';

class LanguageView extends StatelessWidget {
  static const String routeName = '/language';

  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: context.onSurfaceColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          s.languageTitle,
          style: context.font14PrimarySemiBoldSpacing,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.getMainGradient(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                GlassCard(
                  child: BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, state) {
                      final isArabic =
                          context.read<LanguageCubit>().isArabic ?? true;
                      return Column(
                        children: [
                          _buildLanguageTile(
                            context,
                            s.english,
                            'English',
                            !isArabic,
                            () {
                              if (isArabic) {
                                context.read<LanguageCubit>().toggleLanguage();
                              }
                            },
                          ),
                          Divider(
                            color: context.onSurfaceColor.withValues(
                              alpha: 0.1,
                            ),
                            height: 1,
                          ),
                          _buildLanguageTile(
                            context,
                            s.arabic,
                            'Arabic',
                            isArabic,
                            () {
                              if (!isArabic) {
                                context.read<LanguageCubit>().toggleLanguage();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final onSurface = context.onSurfaceColor;
    return ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(fontSize: 16, color: onSurface)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: context.labelColor, fontSize: 12),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: context.primaryColor)
          : null,
    );
  }
}
