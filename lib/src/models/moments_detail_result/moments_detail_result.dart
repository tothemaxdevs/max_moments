import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';
import 'moment.dart';

part 'moments_detail_result.g.dart';

@JsonSerializable()
class MomentsDetailResult {
  Moment? moment;
  List<Comment>? comments;

  MomentsDetailResult({this.moment, this.comments});

  @override
  String toString() {
    return 'MomentsDetailResult(moment: $moment, comments: $comments)';
  }

  factory MomentsDetailResult.fromJson(Map<String, dynamic> json) {
    return _$MomentsDetailResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MomentsDetailResultToJson(this);

  MomentsDetailResult copyWith({
    Moment? moment,
    List<Comment>? comments,
  }) {
    return MomentsDetailResult(
      moment: moment ?? this.moment,
      comments: comments ?? this.comments,
    );
  }
}
