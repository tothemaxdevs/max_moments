import 'package:max_moments/src/models/all_reply_list_result/reply.dart';

class ReplyDetailResult {
  final Reply reply;

  ReplyDetailResult({
    required this.reply,
  });

  factory ReplyDetailResult.fromJson(Map<String, dynamic> json) {
    return ReplyDetailResult(
      reply: Reply.fromJson(json['reply']),
    );
  }
}
