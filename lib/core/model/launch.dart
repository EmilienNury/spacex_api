import 'package:json_annotation/json_annotation.dart';

part 'launch.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launch {
  String id;
  String? name;
  DateTime? date_utc;
  bool? success;
  String? landpad;
  String? launchpad;
  String? small;

  Launch(
      {required this.id,
        this.name,
        this.date_utc,
        this.success,
        this.landpad,
        this.launchpad,
        this.small});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
