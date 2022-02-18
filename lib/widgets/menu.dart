import 'package:flutter/material.dart';
import 'package:mypuzzle/widgets/move.dart';
import 'package:mypuzzle/widgets/reset_button.dart';
import 'package:mypuzzle/widgets/time.dart';

class Menu extends StatelessWidget {
  final Function reset;
  final int move;
  final int secondsPassed;
  final Size size;

  const Menu(
      {Key? key,
      required this.reset,
      required this.move,
      required this.secondsPassed,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ResetButton(reset: reset, text: "Reset"),
          Move(move: move),
          Time(secondsPassed: secondsPassed),
        ],
      ),
    );
  }
}
