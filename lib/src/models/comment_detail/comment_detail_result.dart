import 'package:max_moments/src/models/all_comment_list_result/comment.dart';

class CommentDetailResult {
  final Comment comment;

  CommentDetailResult({
    required this.comment,
  });

  factory CommentDetailResult.fromJson(Map<String, dynamic> json) {
    return CommentDetailResult(
      comment: Comment.fromJson(json['comment']),
    );
  }
}
