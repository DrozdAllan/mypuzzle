import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';

class RandomPuzzle extends ConsumerStatefulWidget {
  const RandomPuzzle({Key? key}) : super(key: key);

  static const routeName = '/random';

  @override
  _RandomPuzzleState createState() => _RandomPuzzleState();
}

class _RandomPuzzleState extends ConsumerState<RandomPuzzle> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(viewIndexProvider.notifier);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text("Select the image (and the difficulty) of your choice"),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              height: 200,
              child: Placeholder()),
          SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              height: 200,
              child: Placeholder()),
          SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              height: 200,
              child: Placeholder()),
        ],
      ),
      ElevatedButton(
          onPressed: () => notifier.changeIndex(4), child: Text('Start !'))
    ]);
  }
}
