import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';
import 'pagination.dart';

part 'all_comment_list_result.g.dart';

@JsonSerializable()
class AllCommentListResult {
  List<Comment>? comments;
  Pagination? pagination;

  AllCommentListResult({this.comments, this.pagination});

  @override
  String toString() {
    return 'AllCommentListResult(comments: $comments, pagination: $pagination)';
  }

  factory AllCommentListResult.fromJson(Map<String, dynamic> json) {
    return _$AllCommentListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllCommentListResultToJson(this);

  AllCommentListResult copyWith({
    List<Comment>? comments,
    Pagination? pagination,
  }) {
    return AllCommentListResult(
      comments: comments ?? this.comments,
      pagination: pagination ?? this.pagination,
    );
  }
}
