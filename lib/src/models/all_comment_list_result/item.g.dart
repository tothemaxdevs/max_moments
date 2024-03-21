// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      number: json['number'] as int?,
      id: json['id'] as String?,
      momentId: json['moment_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      isMerchant: json['is_merchant'] as bool?,
      restaurantName: json['restaurant_name'] as String?,
      restaurantImage: json['restaurant_image'] as String?,
      userAvatar: json['user_avatar'] as String?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      momentsPassed: json['moments_passed'] as String?,
      replyCount: json['reply_count'] as int?,
      replies: json['replies'] == null
          ? null
          : Replies.fromJson(json['replies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'number': instance.number,
      'id': instance.id,
      'moment_id': instance.momentId,
      'user_id': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'is_merchant': instance.isMerchant,
      'restaurant_name': instance.restaurantName,
      'restaurant_image': instance.restaurantImage,
      'user_avatar': instance.userAvatar,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'moments_passed': instance.momentsPassed,
      'reply_count': instance.replyCount,
      'replies': instance.replies,
    };
