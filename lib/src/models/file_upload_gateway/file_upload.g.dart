// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUpload _$FileUploadFromJson(Map<String, dynamic> json) => FileUpload(
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => Files.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FileUploadToJson(FileUpload instance) =>
    <String, dynamic>{
      'files': instance.files,
    };
