import 'package:json_annotation/json_annotation.dart';

import 'pagination.dart';
import 'reply.dart';

part 'all_reply_list_result.g.dart';

@JsonSerializable()
class AllReplyListResult {
  List<Reply>? replies;
  Pagination? pagination;

  AllReplyListResult({this.replies, this.pagination});

  @override
  String toString() {
    return 'AllReplyListResult(replies: $replies, pagination: $pagination)';
  }

  factory AllReplyListResult.fromJson(Map<String, dynamic> json) {
    return _$AllReplyListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllReplyListResultToJson(this);

  AllReplyListResult copyWith({
    List<Reply>? replies,
    Pagination? pagination,
  }) {
    return AllReplyListResult(
      replies: replies ?? this.replies,
      pagination: pagination ?? this.pagination,
    );
  }
}
