import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kt_dart/kt.dart';
import 'package:tic_tac_toe/data/dto/game.dart';

class TicTacToeApi {
  final String _baseUrl = "https://tik-tak-tioki.fly.dev/api/";

  Future<KtList<Game>> fetchOpenGames() async {
    final response = await http.get(Uri.parse("$_baseUrl/join"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((i) => Game.fromJson(i))
          .toImmutableList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
