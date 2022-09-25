import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.ticTacToeApi, required this.game})
      : super(GameState(game: game)) {
    on<LoadGame>(_loadGame);
  }

  final TicTacToeApi ticTacToeApi;
  Game game;

  void _loadGame(LoadGame event, Emitter<GameState> emit) async {
    try {
      game = await ticTacToeApi.loadGame(game.player_token!);
      emit(GameState(
        game: game,
      ));
    } catch (error) {
      // todo show error
      print(error);
    }
  }
}

class GameEvent {}

// class GetOpenGames extends GameEvent {}
//
// class CreateNewGame extends GameEvent {}
//
class LoadGame extends GameEvent {}

class GameState {
  final Game game;

  GameState({required this.game});

  GameState copyWith({
    Game? game,
  }) {
    return GameState(
      game: game ?? this.game,
    );
  }
}
