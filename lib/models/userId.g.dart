// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userId.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserId _$UserIdFromJson(Map<String, dynamic> json) {
  return UserId()
    ..id = json['id'] as int
    ..token = json['token'] as String;
}

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
    };
