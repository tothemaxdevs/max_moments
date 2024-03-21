// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_reply_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllReplyListResult _$AllReplyListResultFromJson(Map<String, dynamic> json) =>
    AllReplyListResult(
      replies: json['replies'] == null
          ? null
          : Replies.fromJson(json['replies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllReplyListResultToJson(AllReplyListResult instance) =>
    <String, dynamic>{
      'replies': instance.replies,
    };
