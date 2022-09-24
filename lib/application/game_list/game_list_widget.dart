import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
      body: LoaderOverlay(
        child: BlocProvider(
          create: (context) =>
              GameListBloc(ticTacToeApi: ticTacToeApi)..add(GetOpenGames()),
          child: BlocBuilder<GameListBloc, GameListState>(
            builder: (context, state) {
              if (state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              final bloc = BlocProvider.of<GameListBloc>(context);
              final openGames = state.openGames;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: openGames.size,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 80,
                            child: Center(child: Text(openGames[index].name)),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () => bloc.add(CreateNewGame()),
                        icon: const Icon(Icons.add),
                        label: const Text("Create new game"))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
