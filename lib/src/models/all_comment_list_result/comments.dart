import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
import 'pagination.dart';

part 'comments.g.dart';

@JsonSerializable()
class Comments {
  List<Item>? items;
  Pagination? pagination;

  Comments({this.items, this.pagination});

  @override
  String toString() => 'Comments(items: $items, pagination: $pagination)';

  factory Comments.fromJson(Map<String, dynamic> json) {
    return _$CommentsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentsToJson(this);

  Comments copyWith({
    List<Item>? items,
    Pagination? pagination,
  }) {
    return Comments(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }
}
