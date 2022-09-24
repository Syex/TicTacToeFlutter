import 'package:json_annotation/json_annotation.dart';

part 'join_game_request.g.dart';

@JsonSerializable()
class JoinGameRequest {
  @JsonKey(required: true)
  final String name;

  JoinGameRequest(this.name);

  Map<String, dynamic> toJson() => _$JoinGameRequestToJson(this);

  @override
  String toString() {
    return 'JoinGameRequest{name: $name}';
  }
}
