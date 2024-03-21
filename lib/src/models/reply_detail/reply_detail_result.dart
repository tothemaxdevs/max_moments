import 'package:max_moments/src/models/all_reply_list_result/item.dart';

class ReplyDetailResult {
  final Item reply;

  ReplyDetailResult({
    required this.reply,
  });

  factory ReplyDetailResult.fromJson(Map<String, dynamic> json) {
    return ReplyDetailResult(
      reply: Item.fromJson(json['reply']),
    );
  }
}
