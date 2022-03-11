import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/core/model/core.dart';
import 'package:spacex_api/core/model/links.dart';

part 'launch.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launch {
  String id;
  String? name;
  DateTime? date_utc;
  bool? success;
  String? launchpad;
  List<Core>? cores;
  Links? links;
  String? details;

  Launch(
      {required this.id,
      this.name,
      this.date_utc,
      this.success,
      this.launchpad,
      this.cores,
      this.links,
      this.details});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
