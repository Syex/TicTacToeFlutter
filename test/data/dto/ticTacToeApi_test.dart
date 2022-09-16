import 'package:test/test.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

void main() {
  test('fetchOpenGames() should return a list of open games', () async {
    final api = TicTacToeApi();

    final games = await api.fetchOpenGames();

    for (final game in games.iter) {
      print(game);
    }
  });
}
