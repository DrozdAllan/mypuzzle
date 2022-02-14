import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // final notifier = ref.read(viewIndexProvider.notifier);
    final puzzleChoice = ref.read(puzzleProvider);

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(width: 100, height: 100, child: Placeholder()),
          SizedBox(width: 100, height: 100, child: Placeholder()),
        ],
      ),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        width: 500,
        height: 500,
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            Image.asset('puzzles/frodondejardin/easy/01.png'),
            Image.asset('puzzles/frodondejardin/easy/02.png'),
            Image.asset('puzzles/frodondejardin/easy/03.png'),
            Image.asset('puzzles/frodondejardin/easy/04.png'),
            Image.asset('puzzles/frodondejardin/easy/05.png'),
            Image.asset('puzzles/frodondejardin/easy/06.png'),
            Image.asset('puzzles/frodondejardin/easy/07.png'),
            Image.asset('puzzles/frodondejardin/easy/08.png'),
            Image.asset('puzzles/frodondejardin/easy/09.png'),
          ],
        ),
      ),
    ]);
  }
}
