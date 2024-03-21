import 'package:json_annotation/json_annotation.dart';

import 'comments.dart';

part 'all_comment_list_result.g.dart';

@JsonSerializable()
class AllCommentListResult {
  Comments? comments;

  AllCommentListResult({this.comments});

  @override
  String toString() => 'AllCommentListResult(comments: $comments)';

  factory AllCommentListResult.fromJson(Map<String, dynamic> json) {
    return _$AllCommentListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllCommentListResultToJson(this);

  AllCommentListResult copyWith({
    Comments? comments,
  }) {
    return AllCommentListResult(
      comments: comments ?? this.comments,
    );
  }
}
