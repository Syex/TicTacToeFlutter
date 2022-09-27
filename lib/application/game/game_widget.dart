import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
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
              child: buildGameScreen(
                  state, (int fieldIndex) => bloc.add(Move(fieldIndex))),
            );
          },
        ),
      ),
    );
  }

  Widget buildGameScreen(GameState state, Function(int) onFieldTap) {
    if (state is Initial) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is ActiveGame) {
      return Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          Center(
            child: AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              firstChild: buildTurnText(state.isMyTurn()),
              secondChild: buildTurnText(!state.isMyTurn()),
              crossFadeState: state.isMyTurn()
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 64)),
          buildTicTacToeRow(0, state.getRow(0), state.game.player_role!,
              state.isMyTurn(), onFieldTap),
          buildTicTacToeRow(1, state.getRow(1), state.game.player_role!,
              state.isMyTurn(), onFieldTap),
          buildTicTacToeRow(2, state.getRow(2), state.game.player_role!,
              state.isMyTurn(), onFieldTap),
        ],
      );
    } else {
      throw Exception("State $state has no handling");
    }
  }

  Row buildTicTacToeRow(int rowIndex, KtList<String> board, String playerRole,
      bool isMyTurn, Function(int) onTap) {
    double width = 100.0;
    double height = 100.0;

    final firstField = board.get(0);
    final secondField = board.get(1);
    final thirdField = board.get(2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(border: Border.all()),
          child: buildFieldWidget(
              firstField, playerRole, isMyTurn, () => onTap(rowIndex * 3)),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(border: Border.all()),
          child: buildFieldWidget(
              secondField, playerRole, isMyTurn, () => onTap(rowIndex * 3 + 1)),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(border: Border.all()),
          child: buildFieldWidget(
              thirdField, playerRole, isMyTurn, () => onTap(rowIndex * 3 + 2)),
        ),
      ],
    );
  }

  Widget buildFieldWidget(
      String field, String playerRole, bool isMyTurn, Function onTap) {
    if (isMyTurn && identical(field, "f")) {
      return InkWell(
        onTap: () => onTap(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
        ),
      );
    } else {
      return CustomPaint(
        painter: painterForField(field, identical(field, playerRole)),
      );
    }
  }

  CustomPainter painterForField(String field, bool fieldOwnedByMe) {
    if (identical(field, "x")) {
      return DrawCross(fieldOwnedByMe);
    } else if (identical(field, "o")) {
      return DrawCircle(fieldOwnedByMe);
    } else {
      return DrawNothing();
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

class DrawNothing extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DrawCircle extends CustomPainter {
  final bool ownedByMe;

  DrawCircle(this.ownedByMe);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ownedByMe ? Colors.green : Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DrawCross extends CustomPainter {
  final bool ownedByMe;

  DrawCross(this.ownedByMe);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ownedByMe ? Colors.green : Colors.red;
    paint.strokeWidth = 2.0;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
