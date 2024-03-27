// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      userAvatar: json['user_avatar'] as String?,
      isMerchant: json['is_merchant'] as bool?,
      restaurantName: json['restaurant_name'] as String?,
      restaurantImage: json['restaurant_image'] as String?,
      reply: json['reply'] as String?,
      createdAt: json['created_at'] as String?,
      momentsPassed: json['moments_passed'] as String?,
      replyTo: json['reply_to'] as String?,
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'user_avatar': instance.userAvatar,
      'is_merchant': instance.isMerchant,
      'restaurant_name': instance.restaurantName,
      'restaurant_image': instance.restaurantImage,
      'reply': instance.reply,
      'created_at': instance.createdAt,
      'moments_passed': instance.momentsPassed,
      'reply_to': instance.replyTo,
    };
