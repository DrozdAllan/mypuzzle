import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mypuzzle/models/image_lists.dart';
import 'package:mypuzzle/providers/puzzle_provider.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';

class Game extends ConsumerStatefulWidget {
  const Game({Key? key}) : super(key: key);

  static const routeName = '/game';

  @override
  _GameState createState() => _GameState();
}

class _GameState extends ConsumerState<Game> {
  List<int> gameSet = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    // final notifier = ref.read(viewIndexProvider.notifier);
    List<String>? puzzleChoice = ref.read(puzzleProvider);
    final List<Image> imagePieces;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(width: 100, height: 100, child: Placeholder()),
          SizedBox(width: 100, height: 100, child: Placeholder()),
        ],
      ),
      _GameGrid(puzzleChoice: puzzleChoice),
    ]);
  }
}

class _GameGrid extends StatefulWidget {
  final List<String>? puzzleChoice;
  const _GameGrid({
    Key? key,
    required this.puzzleChoice,
  }) : super(key: key);

  @override
  __GameGridState createState() => __GameGridState();
}

class __GameGridState extends State<_GameGrid> {
  List<Offset> zinzin = const [
    Offset(0, 0),
    Offset(1, 0),
    Offset(2, 0),
    Offset(0, 1),
    Offset(1, 1),
    Offset(2, 1),
    Offset(0, 3),
    Offset(1, 3),
    Offset(2, 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      width: 500,
      height: 500,
      child: Column(
        children: [
          // Definir le nb de row en fonction de la difficulté ?
          // mettre 8 image pieces et 1 sizedBox vide
          // onTap() vérifier selon x,y si y a sized box a x+1 || x-1 || y+1 || y-1
          // si oui, animatedFoo ou je sais pas, et tu recalcules la grille
          Row(
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Image.asset(widget.puzzleChoice!.elementAt(0)),
              ),
              SizedBox(
                width: 160,
                height: 160,
                child: Image.asset(widget.puzzleChoice!.elementAt(1)),
              ),
              SizedBox(
                width: 160,
                height: 160,
                child: Image.asset(widget.puzzleChoice!.elementAt(2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
