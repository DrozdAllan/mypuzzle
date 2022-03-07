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
  int? selectedImg;

  @override
  Widget build(BuildContext context) {
    final viewIndexNotifier = ref.read(viewIndexProvider.notifier);
    // final puzzleNotifier = ref.read(puzzleProvider.notifier);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text("Select the image (and the difficulty) of your choice"),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              border: selectedImg == 1
                  ? Border.all(color: Colors.red, width: 5.0)
                  : null,
            ),
            width: MediaQuery.of(context).size.width / 6,
            height: 200,
            child: GestureDetector(
              onTap: () => setState(() {
                selectedImg = 1;
              }),
              child: Image.asset('images/frodondejardin.png'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: selectedImg == 2
                  ? Border.all(color: Colors.red, width: 5.0)
                  : null,
            ),
            width: MediaQuery.of(context).size.width / 6,
            height: 200,
            child: GestureDetector(
              onTap: () => setState(() {
                selectedImg = 2;
              }),
              child: Image.asset('images/frodondejardin.png'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: selectedImg == 3
                  ? Border.all(color: Colors.red, width: 5.0)
                  : null,
            ),
            width: MediaQuery.of(context).size.width / 6,
            height: 200,
            child: GestureDetector(
              onTap: () => setState(() {
                selectedImg = 3;
              }),
              child: Image.asset('images/frodondejardin.png'),
            ),
          ),
        ],
      ),
      // TODO: maybe add difficulty ?
      ElevatedButton(
          onPressed: () {
            // puzzleNotifier.choosePuzzle(selectedImg!);
            viewIndexNotifier.changeIndex(3);
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => Board()));
          },
          child: const Text('Start !')),
    ]);
  }
}
