import 'package:json_annotation/json_annotation.dart';

part 'moment.g.dart';

@JsonSerializable()
class Moment {
  String? id;
  String? caption;
  @JsonKey(name: 'allow_comment')
  bool? allowComment;
  String? thumbnail;
  @JsonKey(name: 'media_type')
  String? mediaType;
  String? media;
  int? views;
  @JsonKey(name: 'restaurant_id')
  String? restaurantId;
  @JsonKey(name: 'user_id')
  dynamic userId;
  String? uploader;
  String? avatar;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'moments_passed')
  String? momentsPassed;
  @JsonKey(name: 'like_count')
  int? likeCount;
  @JsonKey(name: 'comment_count')
  int? commentCount;
  @JsonKey(name: 'is_liked')
  bool? isLiked;

  Moment({
    this.id,
    this.caption,
    this.allowComment,
    this.thumbnail,
    this.mediaType,
    this.media,
    this.views,
    this.restaurantId,
    this.userId,
    this.uploader,
    this.avatar,
    this.createdAt,
    this.momentsPassed,
    this.likeCount,
    this.commentCount,
    this.isLiked,
  });

  @override
  String toString() {
    return 'Moment(id: $id, caption: $caption, allowComment: $allowComment, thumbnail: $thumbnail, mediaType: $mediaType, media: $media, views: $views, restaurantId: $restaurantId, userId: $userId, uploader: $uploader, avatar: $avatar, createdAt: $createdAt, momentsPassed: $momentsPassed, likeCount: $likeCount, commentCount: $commentCount, isLiked: $isLiked)';
  }

  factory Moment.fromJson(Map<String, dynamic> json) {
    return _$MomentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MomentToJson(this);

  Moment copyWith({
    String? id,
    String? caption,
    bool? allowComment,
    String? thumbnail,
    String? mediaType,
    String? media,
    int? views,
    String? restaurantId,
    dynamic userId,
    String? uploader,
    String? avatar,
    String? createdAt,
    String? momentsPassed,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return Moment(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      allowComment: allowComment ?? this.allowComment,
      thumbnail: thumbnail ?? this.thumbnail,
      mediaType: mediaType ?? this.mediaType,
      media: media ?? this.media,
      views: views ?? this.views,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: userId ?? this.userId,
      uploader: uploader ?? this.uploader,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      momentsPassed: momentsPassed ?? this.momentsPassed,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
