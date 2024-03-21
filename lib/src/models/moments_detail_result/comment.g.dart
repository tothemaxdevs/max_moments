// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      number: json['number'] as int?,
      id: json['id'] as String?,
      momentId: json['moment_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      isMerchant: json['is_merchant'] as bool?,
      userAvatar: json['user_avatar'] as String?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      momentsPassed: json['moments_passed'] as String?,
      replyCount: json['reply_count'] as int?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'number': instance.number,
      'id': instance.id,
      'moment_id': instance.momentId,
      'user_id': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'is_merchant': instance.isMerchant,
      'user_avatar': instance.userAvatar,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'moments_passed': instance.momentsPassed,
      'reply_count': instance.replyCount,
    };
