import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/alert.dart';

part 'alert_model.g.dart';

@JsonSerializable(createToJson: false)
class AlertModel {
  final String headline;
  final String msgtype;
  final String severity;
  final String urgency;
  final String areas;
  final String category;
  final String certainty;
  final String event;
  final String note;
  final String effective;
  final String expires;
  final String desc;
  final String instruction;

  const AlertModel({
    required this.headline,
    required this.msgtype,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.category,
    required this.certainty,
    required this.event,
    required this.note,
    required this.effective,
    required this.expires,
    required this.desc,
    required this.instruction,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  Alert toEntity() {
    return Alert(
      headline: headline,
      msgtype: msgtype,
      severity: severity,
      urgency: urgency,
      areas: areas,
      category: category,
      certainty: certainty,
      event: event,
      note: note,
      effective: effective,
      expires: expires,
      desc: desc,
      instruction: instruction,
    );
  }
}
