import 'package:flutter/material.dart';

class RandomPuzzle extends StatefulWidget {
  const RandomPuzzle({Key? key}) : super(key: key);

  static const routeName = '/random';

  @override
  _RandomPuzzleState createState() => _RandomPuzzleState();
}

class _RandomPuzzleState extends State<RandomPuzzle> {
  @override
  Widget build(BuildContext context) {
    return
        //  Expanded(
        //   child:
        Column(
      children: [
        Text('random'),
      ],
      //   ),
    );
  }
}
