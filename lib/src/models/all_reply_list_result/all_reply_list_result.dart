import 'package:json_annotation/json_annotation.dart';

import 'replies.dart';

part 'all_reply_list_result.g.dart';

@JsonSerializable()
class AllReplyListResult {
  Replies? replies;

  AllReplyListResult({this.replies});

  @override
  String toString() => 'AllReplyListResult(replies: $replies)';

  factory AllReplyListResult.fromJson(Map<String, dynamic> json) {
    return _$AllReplyListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllReplyListResultToJson(this);

  AllReplyListResult copyWith({
    Replies? replies,
  }) {
    return AllReplyListResult(
      replies: replies ?? this.replies,
    );
  }
}
