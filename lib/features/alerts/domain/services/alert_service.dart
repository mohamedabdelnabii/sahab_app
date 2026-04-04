import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sahab/features/alerts/data/models/alert_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:intl/intl.dart';

class AlertService {
  static const String _alertsKey = 'sahab_intelligent_alerts';
  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  AlertService(this._prefs, this._notificationsPlugin);

  Future<void> initNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> checkWeatherAndGenerateAlerts(Weather weather) async {
    final current = weather.current;
    List<AlertModel> newAlerts = [];

    // Rule 1: High temperature > 35
    if (current.tempC > 35) {
      newAlerts.add(
        _buildAlert(
          title: 'Heat Warning',
          description:
              'Temperatures are dangerously high (> 35°C). Stay hydrated and avoid direct sunlight.',
          type: AlertType.heat,
          severity: AlertSeverity.high,
        ),
      );
    }

    // Rule 2: Low temperature < 10
    if (current.tempC < 10) {
      newAlerts.add(
        _buildAlert(
          title: 'Cold Warning',
          description:
              'Temperatures have dropped below 10°C. Please keep warm.',
          type: AlertType.cold,
          severity: AlertSeverity.medium,
        ),
      );
    }

    // Rule 3: High wind speed > 40 km/h
    if (current.windKph > 40) {
      newAlerts.add(
        _buildAlert(
          title: 'Storm Warning',
          description:
              'High wind speeds detected (> 40 km/h). Secure loose outdoor objects.',
          type: AlertType.storm,
          severity: AlertSeverity.high,
        ),
      );
    }

    // Rule 4: Humidity > 85%
    if (current.humidity > 85) {
      newAlerts.add(
        _buildAlert(
          title: 'High Humidity',
          description: 'Uncomfortable humidity levels exceeding 85%.',
          type: AlertType.humidity,
          severity: AlertSeverity.low,
        ),
      );
    }

    // Rule 5: High cloud coverage > 80% (Inferred from condition text)
    final cond = current.condition.text.toLowerCase();
    int estimatedCloud = 0;
    if (cond.contains('overcast'))
      estimatedCloud = 100;
    else if (cond.contains('cloudy'))
      estimatedCloud = 85;

    if (estimatedCloud > 80) {
      newAlerts.add(
        _buildAlert(
          title: 'Cloud Warning',
          description:
              'High cloud density detected over 80%. Expected poor visibility.',
          type: AlertType.cloud,
          severity: AlertSeverity.medium,
        ),
      );
    }

    await _saveAndNotifyUnique(newAlerts);
  }

  AlertModel _buildAlert({
    required String title,
    required String description,
    required AlertType type,
    required AlertSeverity severity,
  }) {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyyMMdd').format(now);
    return AlertModel(
      id: '${type.name}_$dateStr', // Prevents duplicating the same alert on the same day
      title: title,
      description: description,
      type: type,
      severity: severity,
      timestamp: now,
    );
  }

  Future<void> _saveAndNotifyUnique(List<AlertModel> generatedAlerts) async {
    if (generatedAlerts.isEmpty) return;

    List<AlertModel> existing = await getSavedAlerts();
    bool changed = false;

    for (var newAlert in generatedAlerts) {
      // Avoid duplicate alert logic: Same type within 12 hours
      bool isDupe = existing.any(
        (e) =>
            e.type == newAlert.type &&
            newAlert.timestamp.difference(e.timestamp).inHours < 12,
      );

      if (!isDupe) {
        existing.insert(0, newAlert);
        changed = true;
        _showNotification(newAlert);
      }
    }

    if (changed) {
      final jsonList = existing.map((a) => a.toJson()).toList();
      await _prefs.setStringList(_alertsKey, jsonList);
    }
  }

  Future<List<AlertModel>> getSavedAlerts() async {
    final list = _prefs.getStringList(_alertsKey);
    if (list == null) return [];
    return list.map((e) => AlertModel.fromJson(e)).toList();
  }

  Future<void> clearAlerts() async {
    await _prefs.remove(_alertsKey);
  }

  Future<void> _showNotification(AlertModel alert) async {
    const androidDetails = AndroidNotificationDetails(
      'weather_alerts_channel',
      'Weather Alerts',
      channelDescription: 'Notifications for severe weather',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      alert.hashCode,
      alert.title,
      alert.description,
      details,
    );
  }
}
