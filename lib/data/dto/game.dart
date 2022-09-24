import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  @JsonKey(required: true)
  final String name;
  final String? state;
  final List<String>? board;
  final String? player_token;
  final String? player_role;
  final String? next_move_token;
  @JsonKey(required: true)
  final DateTime created_at;
  final DateTime? updated_at;

  Game(this.name, this.state, this.board, this.player_token, this.player_role,
      this.next_move_token, this.created_at, this.updated_at);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @override
  String toString() {
    return 'Game{name: $name, state: $state, board: $board, player_token: $player_token, player_role: $player_role, next_move_token: $next_move_token, created_at: $created_at, updated_at: $updated_at}';
  }
}
