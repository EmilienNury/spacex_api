import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/core/model/links.dart';
import 'package:spacex_api/core/model/core.dart';

part 'launch.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launch {
  String id;
  String? name;
  DateTime? date_utc;
  bool? success;
  String? landpad;
  List<Core>? cores;
  Links? links;

  Launch(
      {required this.id,
        this.name,
        this.date_utc,
        this.success,
        this.landpad,
        this.cores,
        this.links});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
