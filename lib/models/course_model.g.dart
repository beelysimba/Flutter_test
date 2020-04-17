// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    json['name'] as String,
    thumbnail: (json['thumbnail'] as List)
        .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'name': instance.name,
      'thumbnail': instance.thumbnail,
    };

CourseProject _$CourseProjectFromJson(Map<String, dynamic> json) {
  return CourseProject(
    json['title'] as String,
    json['id'] as String,
    courses: (json['courses'] as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CourseProjectToJson(CourseProject instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'title': instance.title,
      'id': instance.id,
    };

Programme _$ProgrammeFromJson(Map<String, dynamic> json) {
  return Programme(
    json['title'] as String,
    thumbnail: (json['thumbnail'] as List)
        .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProgrammeToJson(Programme instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail.map((e) => e.toJson()).toList(),
      'title': instance.title,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return Thumbnail(
    json['file'] as String,
    json['w'] as String,
    json['h'] as String,
  );
}

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'file': instance.file,
      'w': instance.w,
      'h': instance.h,
    };
