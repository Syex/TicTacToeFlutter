import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:tic_tac_toe/data/dto/game.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  GameListBloc({required this.ticTacToeApi}) : super(GameListState()) {
    on<GetOpenGames>(_mapGetOpenGamesEventToState);
    on<CreateNewGame>(_createNewGame);
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
      // emit(state.copyWith(status: AllGamesStatus.error));
    }
  }

  void _createNewGame(CreateNewGame event, Emitter<GameListState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final newGame = ticTacToeApi.createNewGame();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      // todo show error
    }
  }
}

class GameListEvent {}

class GetOpenGames extends GameListEvent {}

class CreateNewGame extends GameListEvent {}

class GameListState {
  final KtList<Game> openGames;
  final bool isLoading;

  GameListState({this.openGames = const KtList.empty(), this.isLoading = true});

  GameListState copyWith({
    KtList<Game>? openGames,
    bool? isLoading,
  }) {
    return GameListState(
      openGames: openGames ?? this.openGames,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
