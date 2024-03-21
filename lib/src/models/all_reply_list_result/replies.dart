import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
import 'pagination.dart';

part 'replies.g.dart';

@JsonSerializable()
class Replies {
  List<Item>? items;
  Pagination? pagination;

  Replies({this.items, this.pagination});

  @override
  String toString() => 'Replies(items: $items, pagination: $pagination)';

  factory Replies.fromJson(Map<String, dynamic> json) {
    return _$RepliesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RepliesToJson(this);

  Replies copyWith({
    List<Item>? items,
    Pagination? pagination,
  }) {
    return Replies(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }
}
