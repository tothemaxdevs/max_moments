import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'total_item')
  int? totalItem;
  @JsonKey(name: 'total_page')
  int? totalPage;
  @JsonKey(name: 'current_page')
  int? currentPage;
  int? limit;

  Pagination({
    this.totalItem,
    this.totalPage,
    this.currentPage,
    this.limit,
  });

  @override
  String toString() {
    return 'Pagination(totalItem: $totalItem, totalPage: $totalPage, currentPage: $currentPage, limit: $limit)';
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  Pagination copyWith({
    int? totalItem,
    int? totalPage,
    int? currentPage,
    int? limit,
  }) {
    return Pagination(
      totalItem: totalItem ?? this.totalItem,
      totalPage: totalPage ?? this.totalPage,
      currentPage: currentPage ?? this.currentPage,
      limit: limit ?? this.limit,
    );
  }
}
