import 'package:json_annotation/json_annotation.dart';

import 'reply.dart';

part 'post_reply_result.g.dart';

@JsonSerializable()
class PostReplyResult {
  Reply? reply;

  PostReplyResult({this.reply});

  @override
  String toString() => 'PostReplyResult(reply: $reply)';

  factory PostReplyResult.fromJson(Map<String, dynamic> json) {
    return _$PostReplyResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostReplyResultToJson(this);

  PostReplyResult copyWith({
    Reply? reply,
  }) {
    return PostReplyResult(
      reply: reply ?? this.reply,
    );
  }
}
