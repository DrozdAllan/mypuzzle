import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/models/image_lists.dart';

final puzzleProvider = StateNotifierProvider<PuzzleProvider, List<String>?>(
    (ref) => PuzzleProvider());

class PuzzleProvider extends StateNotifier<List<String>?> {
  PuzzleProvider() : super(_puzzleChoice);

  static const List<String>? _puzzleChoice = null;

  // 2) selon cet int, change l'état en une list de imagePieces
  void choosePuzzle(int newIndex) {
    switch (newIndex) {
      case 1:
        log('1 : frodon easy selected');
        state = ImageLists().frodonEasy;
        break;
    }
  }
}
