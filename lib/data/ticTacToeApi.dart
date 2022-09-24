import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kt_dart/kt.dart';
import 'package:tic_tac_toe/data/dto/game.dart';

class TicTacToeApi {
  final String _baseUrl = "https://tik-tak-tioki.fly.dev/api/";

  const TicTacToeApi();

  Future<KtList<Game>> fetchOpenGames() async {
    final response = await http.get(Uri.parse("$_baseUrl/join"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((gameJson) => Game.fromJson(gameJson))
          .toImmutableList();
    } else {
      throw Exception('Failed to load open games: ${response.body}');
    }
  }

  Future<Game> createNewGame() async {
    final response = await http.post(Uri.parse("$_baseUrl/game"));

    if (response.statusCode == 201) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create a new game: ${response.body}');
    }
  }
}
