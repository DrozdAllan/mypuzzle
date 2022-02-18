import 'package:flutter/material.dart';

class Move extends StatelessWidget {
  final int move;

  const Move({Key? key, required this.move}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Move: $move",
        style: const TextStyle(
            color: Colors.white, decoration: TextDecoration.none, fontSize: 18),
      ),
    );
  }
}
