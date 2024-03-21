import 'package:max_moments/src/models/all_comment_list_result/item.dart';

class CommentDetailResult {
  final Item comment;

  CommentDetailResult({
    required this.comment,
  });

  factory CommentDetailResult.fromJson(Map<String, dynamic> json) {
    return CommentDetailResult(
      comment: Item.fromJson(json['comment']),
    );
  }
}
