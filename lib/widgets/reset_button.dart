import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final Function reset;
  final String text;

  const ResetButton({Key? key, required this.reset, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        reset();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: const Text("Reset"),
    );
  }
}
