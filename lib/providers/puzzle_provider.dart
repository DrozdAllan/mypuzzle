import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleProvider =
    StateNotifierProvider<PuzzleProvider, int>((ref) => PuzzleProvider());

class PuzzleProvider extends StateNotifier<int> {
  PuzzleProvider() : super(_puzzleNb);

  static const int _puzzleNb = 0;

  void choosePurrle(int newIndex) {
    state = newIndex;
  }
}
