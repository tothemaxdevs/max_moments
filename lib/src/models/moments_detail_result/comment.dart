import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int? number;
  String? id;
  @JsonKey(name: 'moment_id')
  String? momentId;
  @JsonKey(name: 'user_id')
  String? userId;
  String? name;
  String? username;
  @JsonKey(name: 'is_merchant')
  bool? isMerchant;
  @JsonKey(name: 'user_avatar')
  String? userAvatar;
  String? comment;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'moments_passed')
  String? momentsPassed;
  @JsonKey(name: 'reply_count')
  int? replyCount;

  Comment({
    this.number,
    this.id,
    this.momentId,
    this.userId,
    this.name,
    this.username,
    this.isMerchant,
    this.userAvatar,
    this.comment,
    this.createdAt,
    this.momentsPassed,
    this.replyCount,
  });

  @override
  String toString() {
    return 'Comment(number: $number, id: $id, momentId: $momentId, userId: $userId, name: $name, username: $username, isMerchant: $isMerchant, userAvatar: $userAvatar, comment: $comment, createdAt: $createdAt, momentsPassed: $momentsPassed, replyCount: $replyCount)';
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    int? number,
    String? id,
    String? momentId,
    String? userId,
    String? name,
    String? username,
    bool? isMerchant,
    String? userAvatar,
    String? comment,
    String? createdAt,
    String? momentsPassed,
    int? replyCount,
  }) {
    return Comment(
      number: number ?? this.number,
      id: id ?? this.id,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      username: username ?? this.username,
      isMerchant: isMerchant ?? this.isMerchant,
      userAvatar: userAvatar ?? this.userAvatar,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      momentsPassed: momentsPassed ?? this.momentsPassed,
      replyCount: replyCount ?? this.replyCount,
    );
  }
}
