// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reply_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReplyResult _$PostReplyResultFromJson(Map<String, dynamic> json) =>
    PostReplyResult(
      reply: json['reply'] == null
          ? null
          : Reply.fromJson(json['reply'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostReplyResultToJson(PostReplyResult instance) =>
    <String, dynamic>{
      'reply': instance.reply,
    };
