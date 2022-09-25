import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.ticTacToeApi, required this.game})
      : super(Initial()) {
    on<LoadGame>(_loadGame);
  }

  final TicTacToeApi ticTacToeApi;
  Game game;

  void _loadGame(LoadGame event, Emitter<GameState> emit) async {
    try {
      game = await ticTacToeApi.loadGame(game.player_token!);
      emit(ActiveGame(
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

class GameState {}

class Initial extends GameState {}

class ActiveGame extends GameState {
  final Game game;

  ActiveGame({required this.game});

  bool isMyTurn() {
    return game.state == "your_turn";
  }

  bool didIWin() {
    return game.state == "you_won";
  }

  bool didTheyWin() {
    return game.state == "they_won";
  }

  bool isDraw() {
    return game.state == "draw";
  }

  ActiveGame copyWith({
    Game? game,
  }) {
    return ActiveGame(
      game: game ?? this.game,
    );
  }
}