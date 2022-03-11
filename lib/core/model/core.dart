import 'package:json_annotation/json_annotation.dart';

part 'core.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Core {
  String? landpad;

  Core({this.landpad});

  factory Core.fromJson(Map<String, dynamic> json) => _$CoreFromJson(json);

  Map<String, dynamic> toJson() => _$CoreToJson(this);
}
