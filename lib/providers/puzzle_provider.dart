import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/models/image_lists.dart';
import 'package:mypuzzle/models/tile.dart';

final puzzleProvider = StateNotifierProvider<PuzzleProvider, List<Tile>>(
    (ref) => PuzzleProvider());

class PuzzleProvider extends StateNotifier<List<Tile>> {
  PuzzleProvider() : super(_puzzleChoice);

  static final List<Tile> _puzzleChoice = [
    Tile(xPosition: 0, yPosition: 0, status: 'blank'),
    Tile(xPosition: 1, yPosition: 0, status: 'incorrect'),
    Tile(xPosition: 2, yPosition: 0, status: 'incorrect'),
    Tile(xPosition: 0, yPosition: 1, status: 'incorrect'),
    Tile(xPosition: 1, yPosition: 1, status: 'incorrect'),
    Tile(xPosition: 2, yPosition: 1, status: 'incorrect'),
    Tile(xPosition: 0, yPosition: 2, status: 'incorrect'),
    Tile(xPosition: 1, yPosition: 2, status: 'incorrect'),
    Tile(xPosition: 2, yPosition: 2, status: 'incorrect'),
  ];

  // 2) selon cet int, change l'état en une list de imagePieces
  void swapTile(int tileIndex) {
    Tile leblanc = state.where((element) => element.status == 'blank').first;
    int copyBlankX = leblanc.xPosition;
    int copyBlankY = leblanc.yPosition;
    log('copy ok');

    leblanc.xPosition = state.elementAt(tileIndex).xPosition;
    leblanc.yPosition = state.elementAt(tileIndex).yPosition;
    leblanc.status = state.elementAt(tileIndex).status;

    state.elementAt(tileIndex).status = 'blank';
    state.elementAt(tileIndex).xPosition = copyBlankX;
    state.elementAt(tileIndex).yPosition = copyBlankY;
    // verifier si blank status devient correct ou incorrect
    log('tile to blank ok');
  }
}
