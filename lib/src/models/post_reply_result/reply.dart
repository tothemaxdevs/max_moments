import 'package:json_annotation/json_annotation.dart';

part 'reply.g.dart';

@JsonSerializable()
class Reply {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'comment_id')
  String? commentId;
  String? reply;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Reply({
    this.id,
    this.userId,
    this.commentId,
    this.reply,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Reply(id: $id, userId: $userId, commentId: $commentId, reply: $reply, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);

  Reply copyWith({
    String? id,
    String? userId,
    String? commentId,
    String? reply,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Reply(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      commentId: commentId ?? this.commentId,
      reply: reply ?? this.reply,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
