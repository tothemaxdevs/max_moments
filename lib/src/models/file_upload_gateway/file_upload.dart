import 'package:json_annotation/json_annotation.dart';

import 'files.dart';

part 'file_upload.g.dart';

@JsonSerializable()
class FileUpload {
  List<Files>? files;

  FileUpload({this.files});

  @override
  String toString() => 'FileUpload(files: $files)';

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return _$FileUploadFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileUploadToJson(this);

  FileUpload copyWith({
    List<Files>? files,
  }) {
    return FileUpload(
      files: files ?? this.files,
    );
  }
}
