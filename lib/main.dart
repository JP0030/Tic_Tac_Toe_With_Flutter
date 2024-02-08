import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;
  Duration delay = const Duration(milliseconds: 1500);


  void onCellTapped(int index) {
    if (!gameOver && board[index] == '') {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        gameOver = checkWinner();
        if (gameOver) {
          Future.delayed(delay, () => resetGame());
        }
      });
    }
  }


  bool checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' && board[i] == board[i + 3] && board[i] == board[i + 6]) {
        return true;
      }
      if (board[i * 3] != '' && board[i * 3] == board[i * 3 + 1] && board[i * 3] == board[i * 3 + 2]) {
        return true;
      }
    }
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return true;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return true;
    }
    return board.every((element) => element != '');
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        body: Column(
          children: [
            Text('Current player: $currentPlayer'),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onCellTapped(index),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (gameOver) Text(gameOver ? '$currentPlayer wins!' : 'It\'s a draw!'),
          ],
        ),
      ),
    );
  }
}