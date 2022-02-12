import 'package:flutter/material.dart';

class ImportPuzzle extends StatefulWidget {
  const ImportPuzzle({Key? key}) : super(key: key);

  static const routeName = '/import';

  @override
  _ImportPuzzleState createState() => _ImportPuzzleState();
}

class _ImportPuzzleState extends State<ImportPuzzle> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text("Import an image to make it into a puzzle"),
      ),
      ElevatedButton(onPressed: () {}, child: const Text('Select Image')),
    ]);
  }
}
