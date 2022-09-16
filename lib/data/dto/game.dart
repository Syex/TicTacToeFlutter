import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'game.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
