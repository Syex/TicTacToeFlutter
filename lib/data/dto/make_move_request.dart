import 'package:json_annotation/json_annotation.dart';

part 'make_move_request.g.dart';

@JsonSerializable()
class MakeMoveRequest {
  @JsonKey(required: true)
  final String next_move_token;
  final int field;

  MakeMoveRequest(this.next_move_token, this.field);

  Map<String, dynamic> toJson() => _$MakeMoveRequestToJson(this);

  @override
  String toString() {
    return 'MakeMoveRequest{next_move_token: $next_move_token, field: $field}';
  }
}
