class GameLogic {
  late List<List<int>> board;
  int numRows;
  int numCols;

  GameLogic({required this.numRows, required this.numCols}) {
    // Inicialize o tabuleiro
    board = List.generate(numRows, (index) {
      if (index < numRows ~/ 2) {
        return List.generate(numCols, (index) => 1);
      } else if (index == numRows ~/ 2) {
        return List.generate(numCols, (index) => 0);
      } else {
        return List.generate(numCols, (index) => -1);
      }
    });
  }

  bool isValidMove(int row, int col) {
    // Verifique se a posição selecionada está dentro do tabuleiro
    if (row < 0 || row >= numRows || col < 0 || col >= numCols) {
      return false;
    }
    // Verifique se a posição selecionada contém uma peça
    if (board[row][col] != 1) {
      return false;
    }
    // Verifique se há uma peça adjacente na mesma linha ou coluna
    if ((row > 1 && board[row - 1][col] == 1 && board[row - 2][col] == 0) ||
        (row < numRows - 2 &&
            board[row + 1][col] == 1 &&
            board[row + 2][col] == 0) ||
        (col > 1 && board[row][col - 1] == 1 && board[row][col - 2] == 0) ||
        (col < numCols - 2 &&
            board[row][col + 1] == 1 &&
            board[row][col + 2] == 0)) {
      return true;
    }
    return false;
  }

  void makeMove(int row, int col) {
    // Realize o movimento
    board[row][col] = 0;
    // Remova a peça adjacente
    if (row > 1 && board[row - 1][col] == 1 && board[row - 2][col] == 0) {
      board[row - 1][col] = 0;
    }
    if (row < numRows - 2 &&
        board[row + 1][col] == 1 &&
        board[row + 2][col] == 0) {
      board[row + 1][col] = 0;
    }
    if (col > 1 && board[row][col - 1] == 1 && board[row][col - 2] == 0) {
      board[row][col - 1] = 0;
    }
    if (col < numCols - 2 &&
        board[row][col + 1] == 1 &&
        board[row][col + 2] == 0) {
      board[row][col + 1] = 0;
    }
  }

  bool isGameOver() {
    // Verifique se resta apenas uma peça no tabuleiro
    int count = 0;
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        if (board[i][j] == 1) {
          count++;
        }
      }
    }
    return count == 1;
  }
}
