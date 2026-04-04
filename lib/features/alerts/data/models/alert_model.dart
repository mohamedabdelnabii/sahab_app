import 'dart:convert';

enum AlertType { heat, cold, cloud, storm, humidity }
enum AlertSeverity { low, medium, high }

class AlertModel {
  final String id;
  final String title;
  final String description;
  final AlertType type;
  final AlertSeverity severity;
  final DateTime timestamp;

  AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'severity': severity.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: AlertType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => AlertType.heat,
      ),
      severity: AlertSeverity.values.firstWhere(
        (e) => e.name == map['severity'],
        orElse: () => AlertSeverity.low,
      ),
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertModel.fromJson(String source) =>
      AlertModel.fromMap(json.decode(source));
}
