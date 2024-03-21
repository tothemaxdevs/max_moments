// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentListResult _$MomentListResultFromJson(Map<String, dynamic> json) =>
    MomentListResult(
      moments: (json['moments'] as List<dynamic>?)
          ?.map((e) => Moment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MomentListResultToJson(MomentListResult instance) =>
    <String, dynamic>{
      'moments': instance.moments,
    };
