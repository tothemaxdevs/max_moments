// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      id: json['id'] as String?,
      caption: json['caption'] as String?,
      allowComment: json['allow_comment'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      mediaType: json['media_type'] as String?,
      media: json['media'] as String?,
      views: json['views'] as int?,
      restaurantId: json['restaurant_id'] as String?,
      userId: json['user_id'],
      uploader: json['uploader'] as String?,
      avatar: json['avatar'] as String?,
      createdAt: json['created_at'] as String?,
      momentsPassed: json['moments_passed'] as String?,
      likeCount: json['like_count'] as int?,
      commentCount: json['comment_count'] as int?,
      isLiked: json['is_liked'] as bool?,
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'allow_comment': instance.allowComment,
      'thumbnail': instance.thumbnail,
      'media_type': instance.mediaType,
      'media': instance.media,
      'views': instance.views,
      'restaurant_id': instance.restaurantId,
      'user_id': instance.userId,
      'uploader': instance.uploader,
      'avatar': instance.avatar,
      'created_at': instance.createdAt,
      'moments_passed': instance.momentsPassed,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'is_liked': instance.isLiked,
    };
