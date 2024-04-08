import 'package:flutter/material.dart';
import 'package:game/gamer_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resta Um'),
        ),
        body: Center(
          child: GameBoard(),
        ),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  GameBoardState createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> {
  GameLogic gameLogic = GameLogic(numRows: 7, numCols: 7);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(gameLogic.numRows, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(gameLogic.numCols, (col) {
            return GestureDetector(
              onTap: () {
                if (gameLogic.isValidMove(row, col)) {
                  setState(() {
                    gameLogic.makeMove(row, col);
                  });
                  if (gameLogic.isGameOver()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Game Over'),
                        content: const Text('Parabéns, você ganhou!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: gameLogic.board[row][col] == 1
                      ? Colors.blue
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
