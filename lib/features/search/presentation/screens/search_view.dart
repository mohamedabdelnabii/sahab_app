import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sahab/core/di/injection_container.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/features/search/presentation/cubit/search_cubit.dart';
import 'package:sahab/features/search/domain/entities/location_suggestion.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../core/helpers/spacing.dart';

class SearchView extends StatefulWidget {
  static const String routeName = '/search-view';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchCubit>().search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => gitIt<SearchCubit>()..loadHistory(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Container(
              decoration: AppDecorations.getMainGradient(context),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vGap(20),
                      Center(
                        child: Text(s.search, style: context.font24PrimaryBold),
                      ),
                      vGap(20),
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) =>
                              _onSearchChanged(context, query),
                          style: TextStyle(color: context.onSurfaceColor),
                          decoration: InputDecoration(
                            hintText: s.searchForCityOrAirport,
                            hintStyle: TextStyle(
                              color: context.labelColor.withValues(alpha: 0.5),
                            ),
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: context.labelColor),
                          ),
                        ),
                      ),
                      vGap(20),
                      Expanded(
                        child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              history: (cities) {
                                if (cities.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Type to start searching...',
                                      style: TextStyle(
                                        color: context.labelColor,
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Recent Searches',
                                      style: context.font16PrimaryMedium,
                                    ),
                                    vGap(15),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: cities.length,
                                        itemBuilder: (context, index) {
                                          return _buildHistoryItem(
                                            context,
                                            cities[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              loading: () => Skeletonizer(
                                enabled: true,
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return _buildLocationItem(
                                      context,
                                      const LocationSuggestion(
                                        id: '0',
                                        name: 'City Name',
                                        region: 'Region',
                                        country: 'Country',
                                        lat: 0.0,
                                        lon: 0.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              success: (locations) {
                                if (locations.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No results found',
                                      style: TextStyle(
                                        color: context.labelColor,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: locations.length,
                                  itemBuilder: (context, index) {
                                    final location = locations[index];
                                    return _buildLocationItem(
                                      context,
                                      location,
                                    );
                                  },
                                );
                              },
                              error: (message) => Center(
                                child: Text(
                                  'Error: $message',
                                  style: const TextStyle(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                              orElse: () => const SizedBox(),
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
        },
      ),
    );
  }

  Widget _buildLocationItem(BuildContext context, LocationSuggestion location) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          context.read<SearchCubit>().addToHistory(location.name);
          context.push('/city-weather', extra: location.name);
        },
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: context.primaryColor),
              hGap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: context.font16PrimaryMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${location.region}, ${location.country}',
                      style: context.font14SecondaryRegular,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: context.onSurfaceColor.withValues(alpha: 0.24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String city) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          context.push('/city-weather', extra: city);
        },
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(Icons.history, color: context.labelColor, size: 20),
              hGap(12),
              Text(city, style: context.font16PrimaryMedium),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: context.onSurfaceColor.withValues(alpha: 0.24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
