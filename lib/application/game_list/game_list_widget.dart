import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tic_tac_toe/application/game/game_widget.dart';
import 'package:tic_tac_toe/application/game_list/game_list_bloc.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

class GameListWidget extends StatefulWidget {
  const GameListWidget({
    Key? key,
    required this.ticTacToeApi,
  }) : super(key: key);

  final TicTacToeApi ticTacToeApi;

  @override
  State<GameListWidget> createState() => _GameListWidgetState();
}

class _GameListWidgetState extends State<GameListWidget> {
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select or create a game"),
      ),
      body: LoaderOverlay(
        child: BlocProvider(
          create: (context) => GameListBloc(ticTacToeApi: widget.ticTacToeApi)
            ..add(GetOpenGames()),
          child: BlocListener<GameListBloc, GameListState>(
            listener: (context, state) {
              if (state is NavigateToActiveGame) {
                if (dialogContext != null) {
                  Navigator.of(dialogContext!).pop();
                  dialogContext = null;
                }

                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                                ticTacToeApi: widget.ticTacToeApi,
                                initialGame: state.game),
                            maintainState: false))
                    .then((value) => BlocProvider.of<GameListBloc>(context)
                        .add(GetOpenGames()));
              }
            },
            child: BlocBuilder<GameListBloc, GameListState>(
              builder: (context, state) {
                if (state is! DisplayGames) {
                  return Container();
                }

                evaluateIfLoading(state, context);

                evaluateIfWaitingForAnotherPlayer(state, context);

                final bloc = BlocProvider.of<GameListBloc>(context);
                final openGames = state.openGames;

                return RefreshIndicator(
                  onRefresh: () {
                    bloc.add(GetOpenGames());
                    return Future(() => null);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: openGames.size,
                            itemBuilder: (BuildContext context, int index) {
                              final game = openGames[index];
                              return InkWell(
                                onTap: () => bloc.add(JoinGame(game.name)),
                                child: Container(
                                  height: 80,
                                  child: Center(child: Text(game.name)),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () => bloc.add(CreateNewGame()),
                            icon: const Icon(Icons.add),
                            label: const Text("Create new game"))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void evaluateIfWaitingForAnotherPlayer(
      DisplayGames state, BuildContext context) {
    if (state.isWaitingForAnotherPlayer) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              dialogContext = context;
              return AlertDialog(
                  title: const Text("Waiting for another player..."),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(state.createdGameName!),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                      ),
                      const CircularProgressIndicator()
                    ],
                  ));
            });
      });
    }
  }

  void evaluateIfLoading(DisplayGames state, BuildContext context) {
    if (state.isLoading) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }
}
