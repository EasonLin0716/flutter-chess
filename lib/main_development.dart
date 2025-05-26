import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ChessApp());
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

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
  });
  final PieceType type;
  final PieceColor color;
  Position position;
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
    final movingPiece = pieces.firstWhere((p) =>
        p.position.row == event.from.row && p.position.col == event.from.col);
    movingPiece.position = event.to;
    emit(ChessState(pieces));
  }

  static List<ChessPiece> _initialPieces() {
    return [
      ChessPiece(
        type: PieceType.rook,
        color: PieceColor.white,
        position: const Position(0, 0),
      ),
      ChessPiece(
        type: PieceType.knight,
        color: PieceColor.white,
        position: const Position(0, 1),
      ),
      ChessPiece(
        type: PieceType.bishop,
        color: PieceColor.white,
        position: const Position(0, 2),
      ),
      ChessPiece(
        type: PieceType.queen,
        color: PieceColor.white,
        position: const Position(0, 3),
      ),
      ChessPiece(
        type: PieceType.king,
        color: PieceColor.white,
        position: const Position(0, 4),
      ),
      ChessPiece(
        type: PieceType.bishop,
        color: PieceColor.white,
        position: const Position(0, 5),
      ),
      ChessPiece(
        type: PieceType.knight,
        color: PieceColor.white,
        position: const Position(0, 6),
      ),
      ChessPiece(
        type: PieceType.rook,
        color: PieceColor.white,
        position: const Position(0, 7),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 0),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 1),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 2),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 3),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 4),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 5),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 6),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.white,
        position: const Position(1, 7),
      ),
      ChessPiece(
        type: PieceType.rook,
        color: PieceColor.black,
        position: const Position(7, 0),
      ),
      ChessPiece(
        type: PieceType.knight,
        color: PieceColor.black,
        position: const Position(7, 1),
      ),
      ChessPiece(
        type: PieceType.bishop,
        color: PieceColor.black,
        position: const Position(7, 2),
      ),
      ChessPiece(
        type: PieceType.queen,
        color: PieceColor.black,
        position: const Position(7, 3),
      ),
      ChessPiece(
        type: PieceType.king,
        color: PieceColor.black,
        position: const Position(7, 4),
      ),
      ChessPiece(
        type: PieceType.bishop,
        color: PieceColor.black,
        position: const Position(7, 5),
      ),
      ChessPiece(
        type: PieceType.knight,
        color: PieceColor.black,
        position: const Position(7, 6),
      ),
      ChessPiece(
        type: PieceType.rook,
        color: PieceColor.black,
        position: const Position(7, 7),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 0),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 1),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 2),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 3),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 4),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 5),
      ),
      ChessPiece(
        type: PieceType.pawn,
        color: PieceColor.black,
        position: const Position(6, 6),
      ),
      ChessPiece(
        type: PieceType.pawn,
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
class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final pieces = context.select((ChessBloc bloc) => bloc.state.pieces);

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        itemCount: 64,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          final row = index ~/ 8;
          final col = index % 8;
          final ChessPiece? piece = pieces
                  .where((p) => p.position.row == row && p.position.col == col)
                  .toList()
                  .isNotEmpty
              ? pieces.firstWhere(
                  (p) => p.position.row == row && p.position.col == col)
              : null;
          return GestureDetector(
            onTap: () {
              // 這邊之後可以加入移動邏輯
              print('Tapped on piece at ($row, $col)');
            },
            child: Container(
              color:
                  (row + col) % 2 == 0 ? Colors.brown[300] : Colors.brown[100],
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
    );
  }
}
