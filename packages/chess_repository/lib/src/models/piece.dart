import 'package:equatable/equatable.dart';

// Models
class Position extends Equatable {
  const Position(this.row, this.col);
  final int row;
  final int col;

  @override
  List<Object?> get props => [row, col];

  @override
  String toString() => '($row, $col)';
}

enum PieceType { king, queen, rook, bishop, knight, pawn }

enum PieceColor { white, black }

class ChessPiece {
  ChessPiece({
    required this.type,
    required this.color,
    required this.position,
    required this.move,
  });
  final PieceType type;
  final PieceColor color;
  final void Function() move;
  Position position;
}

class King extends ChessPiece {
  King({
    required super.color,
    required super.position,
    this.hasMoved = false,
    this.canCastle = false,
    this.isChecked = false,
  }) : super(type: PieceType.king, move: () {});

  bool hasMoved;
  bool canCastle;
  bool isChecked;
}

class Queen extends ChessPiece {
  Queen({
    required super.color,
    required super.position,
  }) : super(type: PieceType.queen, move: () {});
}

class Bishop extends ChessPiece {
  Bishop({
    required super.color,
    required super.position,
  }) : super(type: PieceType.bishop, move: () {});
}

class Knight extends ChessPiece {
  Knight({
    required super.color,
    required super.position,
  }) : super(type: PieceType.knight, move: () {});
}

class Rook extends ChessPiece {
  Rook({
    required super.color,
    required super.position,
    this.hasMoved = false,
  }) : super(type: PieceType.rook, move: () {});

  bool hasMoved;
}

class Pawn extends ChessPiece {
  Pawn({
    required super.color,
    required super.position,
    this.hasMoved = false,
  }) : super(type: PieceType.pawn, move: () {});

  bool hasMoved;

  void promote(PieceType newType) {
    // Promote when available
  }

  List<Position> getValidMoves(List<ChessPiece> allPieces) {
    final moves = <Position>[];
    final direction = color == PieceColor.white ? 1 : -1;
    final currentRow = position.row;
    final currentCol = position.col;

    // Forward 1 step
    final oneStep = Position(currentRow + direction, currentCol);
    if (_isEmpty(oneStep, allPieces)) {
      moves.add(oneStep);

      final twoSteps = Position(currentRow + 2 * direction, currentCol);
      if (!hasMoved && _isEmpty(twoSteps, allPieces)) {
        moves.add(twoSteps);
      }
    }

    for (final offset in [-1, 1]) {
      final diag = Position(currentRow + direction, currentCol + offset);
      if (_isEnemy(diag, allPieces)) {
        moves.add(diag);
      }
    }
    return moves;
  }

  bool _isEmpty(Position pos, List<ChessPiece> allPieces) {
    return !allPieces
        .any((p) => p.position.row == pos.row && p.position.col == pos.col);
  }

  bool _isEnemy(Position pos, List<ChessPiece> allPieces) {
    return allPieces.any(
      (p) =>
          p.position.row == pos.row &&
          p.position.col == pos.col &&
          p.color != color,
    );
  }
}
