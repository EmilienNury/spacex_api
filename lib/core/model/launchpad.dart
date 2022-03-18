import 'package:json_annotation/json_annotation.dart';

part 'launchpad.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launchpad {
  double latitude;
  double longitude;
  String? name;
  String? region;

  Launchpad(
      {required this.latitude,
        required this.longitude,
        this.name,
        this.region});

  factory Launchpad.fromJson(Map<String, dynamic> json) => _$LaunchpadFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchpadToJson(this);
}
