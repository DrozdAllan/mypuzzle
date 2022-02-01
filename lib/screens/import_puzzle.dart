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
    return Container(
      child: Text('import'),
    );
  }
}
