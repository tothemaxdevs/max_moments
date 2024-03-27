// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalItem: json['total_item'] as int?,
      totalPage: json['total_page'],
      currentPage: json['current_page'],
      limit: json['limit'],
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total_item': instance.totalItem,
      'total_page': instance.totalPage,
      'current_page': instance.currentPage,
      'limit': instance.limit,
    };
