// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalItem: json['total_item'] as int?,
      totalPage: json['total_page'] as int?,
      currentPage: json['current_page'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total_item': instance.totalItem,
      'total_page': instance.totalPage,
      'current_page': instance.currentPage,
      'limit': instance.limit,
    };
