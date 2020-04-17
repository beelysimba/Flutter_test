
import 'package:json_annotation/json_annotation.dart';
part 'course_model.g.dart';


@JsonSerializable()
class Course extends Object{
  String name;

@JsonKey(nullable:false) 
List<Thumbnail> thumbnail;
Course(this.name, 
       {List<Thumbnail> thumbnail,}) 
        : thumbnail = thumbnail ?? <Thumbnail>[];

factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
        
 Map<String,dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable()
class CourseProject {
 @JsonKey(nullable:false)  
  List<Course> courses;
  String title;
  String id;

  CourseProject(this.title,this.id,{List<Course> courses})
    : courses = courses ?? <Course>[];

  factory CourseProject.fromJson( Map<String,dynamic> json) =>_$CourseProjectFromJson(json);
  Map<String,dynamic> toJson() => _$CourseProjectToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Programme extends Object {
  @JsonKey(nullable:false) 
  List<Thumbnail> thumbnail;
  String title;
  Programme(this.title,{List<Thumbnail> thumbnail,}) 
        : thumbnail = thumbnail ?? <Thumbnail>[];

  factory Programme.fromJson(Map<String, dynamic> json) => _$ProgrammeFromJson(json);
       
  Map<String,dynamic> toJson() => _$ProgrammeToJson(this);
  
}

@JsonSerializable()
class Thumbnail extends Object {
  Thumbnail(this.file,this.w,this.h);
  String file;
  String w;
  String h;

  factory Thumbnail.fromJson(Map<String,dynamic> json) => _$ThumbnailFromJson(json);
  Map<String,dynamic> toJson() => _$ThumbnailToJson(this);
}