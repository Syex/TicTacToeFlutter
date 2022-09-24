// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'created_at'],
  );
  return Game(
    json['name'] as String,
    json['state'] as String?,
    (json['board'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['player_token'] as String?,
    json['player_role'] as String?,
    json['next_move_token'] as String?,
    DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
      'state': instance.state,
      'board': instance.board,
      'player_token': instance.player_token,
      'player_role': instance.player_role,
      'next_move_token': instance.next_move_token,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
