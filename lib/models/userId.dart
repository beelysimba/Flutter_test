import 'package:json_annotation/json_annotation.dart';



part 'userId.g.dart';

@JsonSerializable()
class UserId {
      UserId();

  int id;
  String token;

  factory UserId.fromJson(Map<String,dynamic> json) => _$UserIdFromJson(json);
  Map<String, dynamic> toJson() => _$UserIdToJson(this);
}