import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/alerts/data/models/alert_model.dart';
import 'package:sahab/features/alerts/presentation/cubit/alert_cubit.dart';
import 'package:sahab/features/alerts/presentation/cubit/alert_state.dart';
import 'package:sahab/generated/l10n.dart';
import 'package:intl/intl.dart';

class AlertsScreen extends StatefulWidget {
  static const String routeName = '/alert-view';
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlertCubit>().loadAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).weatherAlerts,
          style: TextStyle(
            color: context.onSurfaceColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: context.onSurfaceColor),
      ),
      body: Container(
        decoration: AppDecorations.getMainGradient(context),
        child: BlocBuilder<AlertCubit, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlertLoaded) {
              if (state.alerts.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).noActiveAlerts,
                    style: TextStyle(
                      color: context.onSurfaceColor,
                      fontSize: 18,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 130,
                  bottom: 20,
                  left: 16,
                  right: 16,
                ),
                itemCount: state.alerts.length,
                itemBuilder: (context, index) {
                  final alert = state.alerts[index];
                  return _buildAlertCard(context, alert);
                },
              );
            } else if (state is AlertError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, AlertModel alert) {
    Color severityColor;
    switch (alert.severity) {
      case AlertSeverity.low:
        severityColor = Colors.yellow.shade700;
        break;
      case AlertSeverity.medium:
        severityColor = Colors.orange;
        break;
      case AlertSeverity.high:
        severityColor = Colors.redAccent;
        break;
    }

    IconData alertIcon;
    switch (alert.type) {
      case AlertType.heat:
        alertIcon = Icons.local_fire_department;
        break;
      case AlertType.cold:
        alertIcon = Icons.ac_unit;
        break;
      case AlertType.cloud:
        alertIcon = Icons.cloud;
        break;
      case AlertType.storm:
        alertIcon = Icons.storm;
        break;
      case AlertType.humidity:
        alertIcon = Icons.water_drop;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: AppDecorations.getGlassDecoration(context),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: severityColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Row(
              children: [
                Icon(alertIcon, color: severityColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    alert.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.onSurfaceColor,
                    ),
                  ),
                ),
                Text(
                  DateFormat('MMM dd, HH:mm').format(alert.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.onSurfaceColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              alert.description,
              style: TextStyle(
                fontSize: 14,
                color: context.onSurfaceColor.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    alert.severity.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                    ),
                  ),
                ),
              ],
            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
