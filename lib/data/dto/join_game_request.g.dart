// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_game_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinGameRequest _$JoinGameRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name'],
  );
  return JoinGameRequest(
    json['name'] as String,
  );
}

Map<String, dynamic> _$JoinGameRequestToJson(JoinGameRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
