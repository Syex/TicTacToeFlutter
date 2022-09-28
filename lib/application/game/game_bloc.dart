import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/dto/make_move_request.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.ticTacToeApi, required this.game})
      : super(Initial()) {
    on<LoadGame>(_loadGame);
    on<Move>(_makeMove);
  }

  final TicTacToeApi ticTacToeApi;
  Game game;

  void _loadGame(LoadGame event, Emitter<GameState> emit) async {
      game = await ticTacToeApi.loadGame(game.player_token!);
      ActiveGame state = ActiveGame(game: game);
      emit(state);

      if (_isEnemyTurn()) {
        _pullGameStatus(emit);
      }
  }

  void _makeMove(Move event, Emitter<GameState> emit) async {
      game = await ticTacToeApi.makeMove(
          MakeMoveRequest(game.next_move_token!, event.fieldIndex),
          game.player_token!);
      ActiveGame state = ActiveGame(game: game);
      emit(state);

      if (_isEnemyTurn()) {
        _pullGameStatus(emit);
      }
  }

  void _pullGameStatus(Emitter<GameState> emit) async {
    while (_isEnemyTurn()) {
      Future.delayed(const Duration(milliseconds: 500));
      game = await ticTacToeApi.loadGame(game.player_token!);
    }

    emit(ActiveGame(game: game));
  }

  bool _isEnemyTurn() {
    return game.state == "their_turn";
  }
}

class GameEvent {}

class Move extends GameEvent {
  final int fieldIndex;

  Move(this.fieldIndex);
}

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

  KtList<String> getRow(int rowNumber) {
    KtMutableList<String> boardList = KtMutableList.from(game.board!);
    boardList.drop(3 * rowNumber);
    return boardList.take(3);
  }

  ActiveGame copyWith({
    Game? game,
  }) {
    return ActiveGame(
      game: game ?? this.game,
    );
  }
}
