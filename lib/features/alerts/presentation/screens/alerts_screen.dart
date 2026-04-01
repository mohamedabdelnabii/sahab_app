import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab/core/di/injection_container.dart';
import 'package:sahab/core/helpers/spacing.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sahab/generated/l10n.dart';
import '../cubit/alerts_cubit.dart';
import '../cubit/alerts_state.dart';
import '../../domain/entities/alert.dart';

class AlertsScreen extends StatefulWidget {
  static const String routeName = '/alerts-view';
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => gitIt<AlertsCubit>()..fetchAlertsForHomeCity(),
      child: Container(
        decoration: AppDecorations.getMainGradient(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<AlertsCubit, AlertsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => _buildAlertsList(context, _dummyAlerts, true, s),
                success: (alerts) => alerts.isEmpty
                    ? _buildEmptyState(context)
                    : _buildAlertsList(context, alerts, false, s),
                error: (message) => _buildErrorState(context, message, s),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAlertsList(
    BuildContext context,
    List<Alert> alerts,
    bool isLoading,
    S s,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: vGap(15.h)),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            expandedHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(s.weatherAlerts, style: context.font24PrimaryBold),
              centerTitle: true,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(child: vGap(30.h)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final alert = alerts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _buildAlertCard(context, alert),
                );
              }, childCount: alerts.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final labelColor = context.labelColor;
    final s = S.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: labelColor.withValues(alpha: 0.24),
          ),
          vGap(16),
          Text(
            s.noActiveAlerts,
            style: context.font16PrimaryMedium.copyWith(color: labelColor),
          ),
          vGap(8),
          Text(
            'Everything seems calm in your area.',
            style: context.font14SecondaryRegular.copyWith(
              color: labelColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, S s) {
    final labelColor = context.labelColor;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: AppColors.error.withValues(alpha: 0.5),
            ),
            vGap(16),
            Text(
              s.failedToFetchAlerts,
              style: context.font16PrimaryMedium.copyWith(color: labelColor),
            ),
            vGap(8),
            Text(
              message,
              style: context.font14SecondaryRegular.copyWith(
                color: labelColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, Alert alert) {
    final severityColor = _getSeverityColor(alert.severity);
    final onSurface = context.onSurfaceColor;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: severityColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: severityColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  alert.severity.toUpperCase(),
                  style: TextStyle(
                    color: severityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(alert.event, style: context.font12Primary54MediumSpacing),
            ],
          ),
          vGap(12),
          Text(
            alert.headline,
            style: context.font16PrimaryMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          vGap(8),
          Text(
            alert.desc,
            style: context.font14SecondaryRegular,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (alert.instruction.isNotEmpty) ...[
            vGap(12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  hGap(8),
                  Expanded(
                    child: Text(
                      alert.instruction,
                      style: context.font12Primary54MediumSpacing.copyWith(
                        color: onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'extreme':
      case 'severe':
      case 'high':
        return Colors.redAccent;
      case 'moderate':
      case 'medium':
        return Colors.orangeAccent;
      default:
        return Colors.yellowAccent;
    }
  }

  static final List<Alert> _dummyAlerts = List.generate(
    3,
    (index) => const Alert(
      headline: 'Loading headline...',
      msgtype: '',
      severity: 'Medium',
      urgency: '',
      areas: '',
      category: '',
      certainty: '',
      event: 'Weather Event',
      note: '',
      effective: '',
      expires: '',
      desc:
          'Loading alert description details here. Please wait while we fetch the latest data.',
      instruction: 'Loading instructions...',
    ),
  );
}
