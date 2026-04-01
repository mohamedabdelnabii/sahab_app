import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sahab/features/settings/presentation/screens/language_view.dart';
import 'package:sahab/features/settings/presentation/screens/privacy_view.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/features/search/presentation/screens/search_view.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../core/helpers/spacing.dart';

class SettingsView extends StatelessWidget {
  static const String routeName = '/setting-view';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: Container(
        decoration: AppDecorations.getMainGradient(context),
        child: SafeArea(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final cubit = context.read<SettingsCubit>();
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  vGap(20),
                  Text(
                    s.settings,
                    style: context.font24PrimaryBold,
                    textAlign: TextAlign.center,
                  ),
                  vGap(30),
                  _buildSectionTitle(context, s.location),
                  _buildSettingsCard(context, [
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, weatherState) {
                        final cityName = weatherState.maybeWhen(
                          success: (w) => w.location.name,
                          orElse: () => s.loading,
                        );
                        return _buildSettingTile(
                          context,
                          Icons.location_on_outlined,
                          s.homeCity,
                          cityName,
                          () => context.push(SearchView.routeName),
                        );
                      },
                    ),
                  ]),
                  vGap(25),
                  _buildSectionTitle(context, s.units),
                  _buildSettingsCard(context, [
                    _buildSwitchTile(
                      context,
                      Icons.thermostat,
                      s.useFahrenheit,
                      state.isCelsius ? s.celsius : s.fahrenheit,
                      !state.isCelsius,
                      (val) => cubit.toggleTemperatureUnit(),
                    ),
                    _buildSettingTile(
                      context,
                      Icons.air,
                      s.windSpeed,
                      state.windUnit,
                      () {},
                    ),
                    _buildSettingTile(
                      context,
                      Icons.compress,
                      s.pressure,
                      state.pressureUnit,
                      () {},
                    ),
                  ]),
                  vGap(25),
                  _buildSectionTitle(context, s.preferences),
                  _buildSettingsCard(context, [
                    _buildSettingTile(
                      context,
                      Icons.language_outlined,
                      s.language,
                      state.language,
                      () => context.push(LanguageView.routeName),
                    ),
                    Divider(
                      color: context.onSurfaceColor.withValues(alpha: 0.1),
                      height: 1,
                    ),
                    _buildSwitchTile(
                      context,
                      Icons.notifications_active_outlined,
                      s.notifications,
                      state.isNotificationsEnabled ? s.enabled : s.disabled,
                      state.isNotificationsEnabled,
                      (val) => cubit.toggleNotifications(),
                    ),
                    Divider(
                      color: context.onSurfaceColor.withValues(alpha: 0.1),
                      height: 1,
                    ),
                    _buildSwitchTile(
                      context,
                      Icons.dark_mode_outlined,
                      s.darkMode,
                      state.isDarkMode ? s.dark : s.light,
                      state.isDarkMode,
                      (val) => cubit.toggleTheme(),
                    ),
                  ]),
                  vGap(25),
                  _buildSectionTitle(context, s.about),
                  _buildSettingsCard(context, [
                    _buildSettingTile(
                      context,
                      Icons.info_outline,
                      s.version,
                      '1.0.0',
                      () {},
                    ),
                    Divider(
                      color: context.onSurfaceColor.withValues(alpha: 0.1),
                      height: 1,
                    ),
                    _buildSettingTile(
                      context,
                      Icons.privacy_tip_outlined,
                      s.privacyPolicy,
                      '',
                      () => context.push(PrivacyView.routeName),
                    ),
                  ]),
                  vGap(100),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: context.labelColor,
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, List<Widget> children) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final activeColor = context.primaryColor;
    final onSurface = context.onSurfaceColor;
    final labelColor = context.labelColor;

    return ListTile(
      leading: Icon(icon, color: onSurface.withValues(alpha: 0.7), size: 22),
      title: Text(title, style: TextStyle(fontSize: 16, color: onSurface)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: labelColor, fontSize: 12),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor.withValues(alpha: 0.5),
        activeThumbColor: activeColor,
        inactiveThumbColor: onSurface.withValues(alpha: 0.5),
        inactiveTrackColor: onSurface.withValues(alpha: 0.1),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    IconData icon,
    String title,
    String trailing,
    VoidCallback onTap,
  ) {
    final onSurface = context.onSurfaceColor;
    final labelColor = context.labelColor;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: onSurface.withValues(alpha: 0.7), size: 22),
      title: Text(title, style: TextStyle(fontSize: 16, color: onSurface)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trailing, style: TextStyle(color: labelColor)),
          hGap(8),
          Icon(
            Icons.chevron_right,
            color: onSurface.withValues(alpha: 0.24),
            size: 18,
          ),
        ],
      ),
    );
  }
}
