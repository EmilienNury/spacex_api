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
          landpad: $checkedConvert('landpad', (v) => v as String?),
          launchpad: $checkedConvert('launchpad', (v) => v as String?),
          small: $checkedConvert('small', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_utc': instance.date_utc?.toIso8601String(),
      'success': instance.success,
      'landpad': instance.landpad,
      'launchpad': instance.launchpad,
      'small': instance.small,
    };
