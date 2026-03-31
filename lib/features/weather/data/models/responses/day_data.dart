import 'package:json_annotation/json_annotation.dart';
import 'condition_data.dart';

part 'day_data.g.dart';

@JsonSerializable(createToJson: false)
class DayData {
  @JsonKey(name: 'maxtemp_c')
  final double? maxtempC;
  
  @JsonKey(name: 'maxtemp_f')
  final double? maxtempF;

  @JsonKey(name: 'mintemp_c')
  final double? mintempC;

  @JsonKey(name: 'mintemp_f')
  final double? mintempF;
  
  final ConditionData? condition;

  DayData({this.maxtempC, this.maxtempF, this.mintempC, this.mintempF, this.condition});

  factory DayData.fromJson(Map<String, dynamic> json) =>
      _$DayDataFromJson(json);
}
