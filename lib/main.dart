import 'package:flutter/material.dart';
import 'package:tic_tac_toe/application/game_list/game_list_widget.dart';
import 'package:tic_tac_toe/data/ticTacToeApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final TicTacToeApi ticTacToeApi = const TicTacToeApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameListWidget(ticTacToeApi: ticTacToeApi),
    );
  }
}
