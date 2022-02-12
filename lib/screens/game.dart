import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final notifier = ref.read(viewIndexProvider.notifier);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(width: 100, height: 100, child: Placeholder()),
          SizedBox(width: 100, height: 100, child: Placeholder()),
        ],
      ),
      const SizedBox(
        width: 500,
        child: Placeholder(),
      ),
    ]);
  }
}
