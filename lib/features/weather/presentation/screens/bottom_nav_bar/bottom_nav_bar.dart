import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/presentation/screens/home_view.dart';
import 'package:sahab/features/radar/presentation/screens/radar_screen.dart';
import 'package:sahab/features/search/presentation/screens/search_view.dart';
import 'package:sahab/features/alerts/presentation/screens/alerts_screen.dart';
import 'package:sahab/features/settings/presentation/screens/settings_view.dart';
import 'package:sahab/core/theme/app_decorations.dart';

class BottomNavBarView extends StatefulWidget {
  static const String routeName = '/bottomNavBar-view';
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const RadarScreen(),
    const SearchView(),
    const AlertsScreen(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: AppDecorations.getGlassDecoration(context).copyWith(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.home_rounded),
                  _buildNavItem(1, Icons.map_rounded),
                  _buildNavItem(2, Icons.search_rounded),
                  _buildNavItem(3, Icons.notifications_rounded),
                  _buildNavItem(4, Icons.settings_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    final primary = context.primaryColor;
    final inactive = context.onSurfaceColor.withValues(alpha: 0.4);

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? primary : inactive,
            size: 26,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
