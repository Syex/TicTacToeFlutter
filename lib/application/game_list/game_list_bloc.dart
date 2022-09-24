import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/dto/join_game_request.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  GameListBloc({required this.ticTacToeApi}) : super(GameListState()) {
    on<GetOpenGames>(_mapGetOpenGamesEventToState);
    on<CreateNewGame>(_createNewGame);
    on<JoinGame>(_joinGame);
  }

  final TicTacToeApi ticTacToeApi;

  void _mapGetOpenGamesEventToState(
      GetOpenGames event, Emitter<GameListState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final openGames = await ticTacToeApi.fetchOpenGames();
      emit(GameListState(
        openGames: openGames,
        isLoading: false,
      ));
    } catch (error) {
      // todo show error
      print(error);
    }
  }

  void _createNewGame(CreateNewGame event, Emitter<GameListState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      var game = await ticTacToeApi.createNewGame();
      emit(state.copyWith(isLoading: false, isWaitingForAnotherPlayer: true));

      while (game.state == "awaiting_join") {
        await Future.delayed(const Duration(seconds: 2));
        game = await ticTacToeApi.loadGame(game.player_token!);
        print(game.state);
      }
    } catch (error) {
      // todo show error
      print(error);
    }
  }

  void _joinGame(JoinGame event, Emitter<GameListState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final newGame = await ticTacToeApi.joinGame(JoinGameRequest(event.name));
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      // todo show error
      print(error);
    }
  }
}

class GameListEvent {}

class GetOpenGames extends GameListEvent {}

class CreateNewGame extends GameListEvent {}

class JoinGame extends GameListEvent {
  final String name;

  JoinGame(this.name);
}

class GameListState {
  final KtList<Game> openGames;
  final bool isLoading;
  final bool isWaitingForAnotherPlayer;

  GameListState(
      {this.openGames = const KtList.empty(),
      this.isLoading = true,
      this.isWaitingForAnotherPlayer = false});

  GameListState copyWith({
    KtList<Game>? openGames,
    bool? isLoading,
    bool? isWaitingForAnotherPlayer,
  }) {
    return GameListState(
        openGames: openGames ?? this.openGames,
        isLoading: isLoading ?? this.isLoading,
        isWaitingForAnotherPlayer:
            isWaitingForAnotherPlayer ?? this.isWaitingForAnotherPlayer);
  }
}
