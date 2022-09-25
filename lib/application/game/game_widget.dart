import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

import '../../data/dto/game.dart';
import 'game_bloc.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({
    Key? key,
    required this.ticTacToeApi,
    required this.initialGame,
  }) : super(key: key);

  final TicTacToeApi ticTacToeApi;
  final Game initialGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(initialGame.name),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) =>
            GameBloc(ticTacToeApi: ticTacToeApi, game: initialGame)
              ..add(LoadGame()),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GameBloc>(context);

            return Container(
              padding: const EdgeInsets.all(16.0),
              child: buildGameScreen(state),
            );
          },
        ),
      ),
    );
  }

  Widget buildGameScreen(GameState state) {
    if (state is Initial) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is ActiveGame) {
      return Column(
        children: [
          Center(
            child: AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              firstChild: buildTurnText(state.isMyTurn()),
              secondChild: buildTurnText(!state.isMyTurn()),
              crossFadeState: state.isMyTurn()
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          )
        ],
      );
    } else {
      throw Exception("State $state has no handling");
    }
  }

  Widget buildTurnText(bool isMyTurn) {
    return Text(
      isMyTurn ? "It's your turn" : "Waiting for enemy's turn",
      style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: isMyTurn ? Colors.green : Colors.deepOrange),
    );
  }
}
