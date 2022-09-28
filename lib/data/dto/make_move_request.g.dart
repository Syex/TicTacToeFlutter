// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_move_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeMoveRequest _$MakeMoveRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['next_move_token'],
  );
  return MakeMoveRequest(
    json['next_move_token'] as String,
    json['field'] as int,
  );
}

Map<String, dynamic> _$MakeMoveRequestToJson(MakeMoveRequest instance) =>
    <String, dynamic>{
      'next_move_token': instance.next_move_token,
      'field': instance.field,
    };
