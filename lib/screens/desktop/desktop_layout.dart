import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';

import 'package:mypuzzle/screens/about.dart';

import 'package:mypuzzle/screens/import_puzzle.dart';
import 'package:mypuzzle/screens/random_puzzle.dart';
import 'package:mypuzzle/screens/stats.dart';

class DesktopLayout extends ConsumerWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  final List<Widget> screens = const <Widget>[
    RandomPuzzle(),
    ImportPuzzle(),
    Stats(),
    About(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(viewIndexProvider);
    final notifier = ref.read(viewIndexProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          CustomPaint(
            painter: MyPainter(),
            child: Column(
              children: [
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Container(
                    padding: const EdgeInsets.all(00),
                    color: Colors.blue[50],
                    child: const FlutterLogo(),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 500,
                  child: ListView(children: [
                    ListTile(
                        title: Text(
                          'Random Puzzle',
                          style: TextStyle(
                              color: index == 0 ? Colors.blue : Colors.black),
                        ),
                        onTap: () => notifier.changeIndex(0)),
                    ListTile(
                        title: Text(
                          'Import Puzzle',
                          style: TextStyle(
                              color: index == 1 ? Colors.blue : Colors.black),
                        ),
                        onTap: () => notifier.changeIndex(1)),
                    ListTile(
                        title: Text(
                          'Stats',
                          style: TextStyle(
                              color: index == 2 ? Colors.blue : Colors.black),
                        ),
                        onTap: () => notifier.changeIndex(2)),
                    ListTile(
                        title: Text(
                          'About',
                          style: TextStyle(
                              color: index == 3 ? Colors.blue : Colors.black),
                        ),
                        onTap: () => notifier.changeIndex(3)),
                  ]),
                ),
              ],
            ),
          ),
          screens.elementAt(index),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width, size.height),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}