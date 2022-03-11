// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Launch',
      json,
      ($checkedConvert) {
        final val = Launch(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          date_utc: $checkedConvert('date_utc',
              (v) => v == null ? null : DateTime.parse(v as String)),
          success: $checkedConvert('success', (v) => v as bool?),
          launchpad: $checkedConvert('launchpad', (v) => v as String?),
          cores: $checkedConvert(
              'cores',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Core.fromJson(e as Map<String, dynamic>))
                  .toList()),
          links: $checkedConvert(
              'links',
              (v) =>
                  v == null ? null : Links.fromJson(v as Map<String, dynamic>)),
          details: $checkedConvert('details', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_utc': instance.date_utc?.toIso8601String(),
      'success': instance.success,
      'launchpad': instance.launchpad,
      'cores': instance.cores?.map((e) => e.toJson()).toList(),
      'links': instance.links?.toJson(),
      'details': instance.details,
    };
