import 'package:json_annotation/json_annotation.dart';

import 'moment.dart';

part 'moment_list_result.g.dart';

@JsonSerializable()
class MomentListResult {
  List<Moment>? moments;

  MomentListResult({this.moments});

  @override
  String toString() => 'MomentListResult(moments: $moments)';

  factory MomentListResult.fromJson(Map<String, dynamic> json) {
    return _$MomentListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MomentListResultToJson(this);

  MomentListResult copyWith({
    List<Moment>? moments,
  }) {
    return MomentListResult(
      moments: moments ?? this.moments,
    );
  }
}
