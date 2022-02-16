import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import 'package:mypuzzle/models/image_lists.dart';
import 'package:mypuzzle/models/tile.dart';
import 'package:mypuzzle/providers/puzzle_provider.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';

class Game extends ConsumerStatefulWidget {
  const Game({Key? key}) : super(key: key);

  static const routeName = '/game';

  @override
  _GameState createState() => _GameState();
}

class _GameState extends ConsumerState<Game> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(width: 100, height: 100, child: Placeholder()),
          SizedBox(width: 100, height: 100, child: Placeholder()),
        ],
      ),
      const _GameGrid(),
    ]);
  }
}

class _GameGrid extends ConsumerStatefulWidget {
  const _GameGrid({
    Key? key,
  }) : super(key: key);

  @override
  __GameGridState createState() => __GameGridState();
}

class __GameGridState extends ConsumerState<_GameGrid> {
  @override
  Widget build(BuildContext context) {
    List<Tile> provider = ref.read(puzzleProvider);

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      width: 500,
      height: 500,
      // Definir le nb de row en fonction de la difficulté ?
      // mettre 8 image pieces et 1 sizedBox vide
      // onTap() vérifier selon x,y si y a sized box a x+1 || x-1 || y+1 || y-1
      // si oui, animatedPosition
      child: Stack(
        children: [
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(0),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(1),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(2),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(3),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(4),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(5),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(6),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(7),
          ),
          TilePiece(
            tileSet: provider,
            tile: provider.elementAt(8),
          ),
        ],
      ),
    );
  }
}

class TilePiece extends ConsumerWidget {
  final List<Tile> tileSet;
  final Tile tile;

  const TilePiece({
    Key? key,
    required this.tile,
    required this.tileSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(puzzleProvider.notifier);
// TODO: follow simple steps like these :
// https://javascript.plainenglish.io/build-an-8-puzzle-game-with-pure-javascript-efe424bc252a
    tryMoving(Tile tile) {
      tileSet.forEachIndexed((index, item) {
        if (item.xPosition == tile.xPosition &&
            item.yPosition == tile.yPosition &&
            item.status == 'blank') {
          log('cest un blank');
        }
        if (item.xPosition == tile.xPosition - 1 &&
            item.yPosition == tile.yPosition &&
            item.status == 'blank') {
          log('le blank est a gauche');

          notifier.swapTile(index);
        }
        if (item.xPosition == tile.xPosition + 1 &&
            item.yPosition == tile.yPosition &&
            item.status == 'blank') {
          log('le blank est a droite');
        }
        if (item.xPosition == tile.xPosition &&
            item.yPosition == tile.yPosition - 1 &&
            item.status == 'blank') {
          log('le blank est au dessus');
        }
        if (item.xPosition == tile.xPosition &&
            item.yPosition == tile.yPosition + 1 &&
            item.status == 'blank') {
          log('le blank est en dessous');
        }
      });
    }

    return Positioned(
      left: tile.xPosition * 166,
      top: tile.yPosition * 166,
      child: GestureDetector(
        onTap: () => tryMoving(tile),
        child: Container(
          width: 166,
          height: 166,
          color: tile.status == 'blank' ? Colors.transparent : Colors.red,
          child: Text(tile.status.toString()),
        ),
      ),
    );
  }
}
