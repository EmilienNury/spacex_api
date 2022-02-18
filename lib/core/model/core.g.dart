// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Core _$CoreFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Core',
      json,
      ($checkedConvert) {
        final val = Core(
          landpad: $checkedConvert('landpad', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$CoreToJson(Core instance) => <String, dynamic>{
      'landpad': instance.landpad,
    };
