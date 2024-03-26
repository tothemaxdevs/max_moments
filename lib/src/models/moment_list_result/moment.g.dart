// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      id: json['id'] as String?,
      media: json['media'] as String?,
      mediaType: json['media_type'] as String?,
      views: json['views'] as int?,
      caption: json['caption'] as String?,
      allowComment: json['allow_comment'] as bool?,
      uploader: json['uploader'] as String?,
      restaurantPhoto: json['restaurant_photo'] as String?,
      createdAt: json['created_at'] as String?,
      momentsPassed: json['moments_passed'] as String?,
      likeCount: json['like_count'] as int?,
      commentCount: json['comment_count'] as int?,
      isLiked: json['is_liked'] as bool?,
      isBookmark: json['is_bookmark'] as bool?,
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'media': instance.media,
      'media_type': instance.mediaType,
      'views': instance.views,
      'caption': instance.caption,
      'allow_comment': instance.allowComment,
      'uploader': instance.uploader,
      'restaurant_photo': instance.restaurantPhoto,
      'created_at': instance.createdAt,
      'moments_passed': instance.momentsPassed,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'is_liked': instance.isLiked,
      'is_bookmark': instance.isBookmark,
    };
