import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'moment_id')
  String? momentId;
  String? comment;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Comment({
    this.id,
    this.userId,
    this.momentId,
    this.comment,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Comment(id: $id, userId: $userId, momentId: $momentId, comment: $comment, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    String? id,
    String? userId,
    String? momentId,
    String? comment,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      momentId: momentId ?? this.momentId,
      comment: comment ?? this.comment,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
