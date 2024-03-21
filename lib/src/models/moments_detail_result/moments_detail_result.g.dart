// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moments_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentsDetailResult _$MomentsDetailResultFromJson(Map<String, dynamic> json) =>
    MomentsDetailResult(
      moment: json['moment'] == null
          ? null
          : Moment.fromJson(json['moment'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MomentsDetailResultToJson(
        MomentsDetailResult instance) =>
    <String, dynamic>{
      'moment': instance.moment,
      'comments': instance.comments,
    };
