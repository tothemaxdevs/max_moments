import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';

part 'post_comment_result.g.dart';

@JsonSerializable()
class PostCommentResult {
  Comment? comment;

  PostCommentResult({this.comment});

  @override
  String toString() => 'PostCommentResult(comment: $comment)';

  factory PostCommentResult.fromJson(Map<String, dynamic> json) {
    return _$PostCommentResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostCommentResultToJson(this);

  PostCommentResult copyWith({
    Comment? comment,
  }) {
    return PostCommentResult(
      comment: comment ?? this.comment,
    );
  }
}
