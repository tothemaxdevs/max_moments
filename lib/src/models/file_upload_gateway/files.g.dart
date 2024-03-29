// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) => Files(
      id: json['id'] as String?,
      targetId: json['target_id'] as String?,
      targetType: json['target_type'] as String?,
      attribute: json['attribute'] as String?,
      code: json['code'] as String?,
      filename: json['filename'] as String?,
      path: json['path'] as String?,
      extension: json['extension'] as String?,
      mime: json['mime'] as String?,
      size: (json['size'] as num?)?.toDouble(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'target_id': instance.targetId,
      'target_type': instance.targetType,
      'attribute': instance.attribute,
      'code': instance.code,
      'filename': instance.filename,
      'path': instance.path,
      'extension': instance.extension,
      'mime': instance.mime,
      'size': instance.size,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
