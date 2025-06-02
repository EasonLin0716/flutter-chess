// ignore_for_file: prefer_const_constructors

import 'package:chess_repository/chess_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChessRepository', () {
    test('can be instantiated', () {
      expect(ChessRepository(), isNotNull);
    });
  });
}
