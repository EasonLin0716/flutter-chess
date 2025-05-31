import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => ChessBloc(),
        child: const ChessBoardScreen(),
      ),
    );
  }
}

// Models
class Position {
  const Position(this.row, this.col);
  final int row;
  final int col;
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
}

// Bloc
abstract class ChessEvent extends Equatable {
  const ChessEvent();
}

class MovePiece extends ChessEvent {
  const MovePiece(this.from, this.to);
  final Position from;
  final Position to;

  @override
  List<Object> get props => [from, to];
}

class ChessState extends Equatable {
  const ChessState(this.pieces);
  final List<ChessPiece> pieces;

  @override
  List<Object> get props => [pieces];
}

class ChessBloc extends Bloc<ChessEvent, ChessState> {
  ChessBloc() : super(ChessState(_initialPieces())) {
    on<MovePiece>(_onMovePiece);
  }

  void _onMovePiece(MovePiece event, Emitter<ChessState> emit) {
    final pieces = List<ChessPiece>.from(state.pieces);
    final movingPiece = pieces.firstWhere(
      (p) =>
          p.position.row == event.from.row && p.position.col == event.from.col,
    )..position = event.to;
    print(movingPiece);
    emit(ChessState(pieces));
  }

  static List<ChessPiece> _initialPieces() {
    return [
      Rook(
        color: PieceColor.white,
        position: const Position(0, 0),
      ),
      Knight(
        color: PieceColor.white,
        position: const Position(0, 1),
      ),
      Bishop(
        color: PieceColor.white,
        position: const Position(0, 2),
      ),
      Queen(
        color: PieceColor.white,
        position: const Position(0, 3),
      ),
      King(
        color: PieceColor.white,
        position: const Position(0, 4),
      ),
      Bishop(
        color: PieceColor.white,
        position: const Position(0, 5),
      ),
      Knight(
        color: PieceColor.white,
        position: const Position(0, 6),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(0, 7),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 0),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 1),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 2),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 3),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 4),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 5),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 6),
      ),
      Pawn(
        color: PieceColor.white,
        position: const Position(1, 7),
      ),
      Rook(
        color: PieceColor.black,
        position: const Position(7, 0),
      ),
      Knight(
        color: PieceColor.black,
        position: const Position(7, 1),
      ),
      Bishop(
        color: PieceColor.black,
        position: const Position(7, 2),
      ),
      Queen(
        color: PieceColor.black,
        position: const Position(7, 3),
      ),
      King(
        color: PieceColor.black,
        position: const Position(7, 4),
      ),
      Bishop(
        color: PieceColor.black,
        position: const Position(7, 5),
      ),
      Knight(
        color: PieceColor.black,
        position: const Position(7, 6),
      ),
      Rook(
        color: PieceColor.black,
        position: const Position(7, 7),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 0),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 1),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 2),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 3),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 4),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 5),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 6),
      ),
      Pawn(
        color: PieceColor.black,
        position: const Position(6, 7),
      ),
    ];
  }
}

// Screens
class ChessBoardScreen extends StatelessWidget {
  const ChessBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chess Board')),
      body: const ChessBoard(),
    );
  }
}

// Widgets
class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  Position? selected;

  @override
  Widget build(BuildContext context) {
    final pieces = context.select((ChessBloc bloc) => bloc.state.pieces);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          itemCount: 64,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder: (context, index) {
            final row = index ~/ 8;
            final col = index % 8;
            final piece = pieces
                    .where(
                      (p) => p.position.row == row && p.position.col == col,
                    )
                    .toList()
                    .isNotEmpty
                ? pieces.firstWhere(
                    (p) => p.position.row == row && p.position.col == col,
                  )
                : null;
            return GestureDetector(
              onTap: () {
                final tapped = Position(row, col);
                if (selected == null && piece != null) {
                  setState(() {
                    selected = tapped;
                  });
                } else if (selected != null) {
                  context.read<ChessBloc>().add(MovePiece(selected!, tapped));
                  setState(() {
                    selected = null;
                  });
                }
              },
              child: Container(
                color:
                    (row + col).isEven ? Colors.brown[300] : Colors.brown[100],
                child: Center(
                  child: piece != null
                      ? Text(
                          piece.type.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            color: piece.color == PieceColor.white
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
