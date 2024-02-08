import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Game state variables
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;

  // Update board on cell tap
  void onCellTapped(int index) {
    if (!gameOver && board[index] == '') {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        gameOver = checkWinner();
      });
    }
  }

  // Check for winner
  bool checkWinner() {
    // Implement winning conditions logic
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' && board[i] == board[i + 3] && board[i] == board[i + 6]) {
        return true; // Row win
      }
      if (board[i * 3] != '' && board[i * 3] == board[i * 3 + 1] && board[i * 3] == board[i * 3 + 2]) {
        return true; // Column win
      }
    }
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return true; // Diagonal win
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return true; // Other diagonal win
    }
    // Check for draw (all cells filled)
    return board.every((element) => element != '');
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
            
          ],
        ),
      ),
    );
  }
}