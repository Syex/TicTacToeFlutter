import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kt_dart/kt.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/dto/join_game_request.dart';

class TicTacToeApi {
  final String _baseUrl = "https://tik-tak-tioki.fly.dev/api";

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

  Future<Game> loadGame(String playerToken) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/game").replace(queryParameters: {
      "player_token": playerToken,
    }));

    if (response.statusCode == 200) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to refresh the game: ${response.body}');
    }
  }

  Future<Game> joinGame(JoinGameRequest request) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/game"),
      body: request.toJson(),
    );

    if (response.statusCode == 201) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to join game ${request.name}: ${response.body}');
    }
  }
}
