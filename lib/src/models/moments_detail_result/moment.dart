import 'package:json_annotation/json_annotation.dart';

part 'moment.g.dart';

@JsonSerializable()
class Moment {
  String? id;
  String? media;
  @JsonKey(name: 'media_type')
  String? mediaType;
  int? views;
  String? caption;
  @JsonKey(name: 'allow_comment')
  bool? allowComment;
  dynamic uploader;
  @JsonKey(name: 'restaurant_photo')
  dynamic restaurantPhoto;
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
    this.media,
    this.mediaType,
    this.views,
    this.caption,
    this.allowComment,
    this.uploader,
    this.restaurantPhoto,
    this.createdAt,
    this.momentsPassed,
    this.likeCount,
    this.commentCount,
    this.isLiked,
  });

  @override
  String toString() {
    return 'Moment(id: $id, media: $media, mediaType: $mediaType, views: $views, caption: $caption, allowComment: $allowComment, uploader: $uploader, restaurantPhoto: $restaurantPhoto, createdAt: $createdAt, momentsPassed: $momentsPassed, likeCount: $likeCount, commentCount: $commentCount, isLiked: $isLiked)';
  }

  factory Moment.fromJson(Map<String, dynamic> json) {
    return _$MomentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MomentToJson(this);

  Moment copyWith({
    String? id,
    String? media,
    String? mediaType,
    int? views,
    String? caption,
    bool? allowComment,
    dynamic uploader,
    dynamic restaurantPhoto,
    String? createdAt,
    String? momentsPassed,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return Moment(
      id: id ?? this.id,
      media: media ?? this.media,
      mediaType: mediaType ?? this.mediaType,
      views: views ?? this.views,
      caption: caption ?? this.caption,
      allowComment: allowComment ?? this.allowComment,
      uploader: uploader ?? this.uploader,
      restaurantPhoto: restaurantPhoto ?? this.restaurantPhoto,
      createdAt: createdAt ?? this.createdAt,
      momentsPassed: momentsPassed ?? this.momentsPassed,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
