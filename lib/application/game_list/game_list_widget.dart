import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/application/game_list/game_list_bloc.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameListWidget extends StatelessWidget {
  const GameListWidget({
    Key? key,
    required this.ticTacToeApi,
  }) : super(key: key);

  final TicTacToeApi ticTacToeApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select or create a game"),
      ),
      body: BlocProvider(
        create: (context) =>
            GameListBloc(ticTacToeApi: ticTacToeApi)..add(GetOpenGames()),
        child: BlocBuilder<GameListBloc, GameListState>(
          builder: (context, state) {
            final openGames = state.openGames;
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: openGames.size,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 80,
                  // color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text(openGames[index].name)),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          },
        ),
      ),
    );
  }
}
