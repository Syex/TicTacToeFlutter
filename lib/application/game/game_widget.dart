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
      body: BlocProvider(
        create: (context) =>
            GameBloc(ticTacToeApi: ticTacToeApi, game: initialGame)
              ..add(LoadGame()),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GameBloc>(context);

            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(),
            );
          },
        ),
      ),
    );
  }
}
