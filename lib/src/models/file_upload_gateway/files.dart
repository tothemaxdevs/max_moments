import 'package:json_annotation/json_annotation.dart';

part 'files.g.dart';

@JsonSerializable()
class Files {
  String? id;
  @JsonKey(name: 'target_id')
  String? targetId;
  @JsonKey(name: 'target_type')
  String? targetType;
  String? attribute;
  String? code;
  String? filename;
  String? path;
  String? extension;
  String? mime;
  double? size;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Files({
    this.id,
    this.targetId,
    this.targetType,
    this.attribute,
    this.code,
    this.filename,
    this.path,
    this.extension,
    this.mime,
    this.size,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'File(id: $id, targetId: $targetId, targetType: $targetType, attribute: $attribute, code: $code, filename: $filename, path: $path, extension: $extension, mime: $mime, size: $size, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);

  Files copyWith({
    String? id,
    String? targetId,
    String? targetType,
    String? attribute,
    String? code,
    String? filename,
    String? path,
    String? extension,
    String? mime,
    double? size,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Files(
      id: id ?? this.id,
      targetId: targetId ?? this.targetId,
      targetType: targetType ?? this.targetType,
      attribute: attribute ?? this.attribute,
      code: code ?? this.code,
      filename: filename ?? this.filename,
      path: path ?? this.path,
      extension: extension ?? this.extension,
      mime: mime ?? this.mime,
      size: size ?? this.size,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
