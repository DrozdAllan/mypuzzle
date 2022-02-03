import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mypuzzle/providers/view_index_provider.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/import_puzzle.dart';
import 'package:mypuzzle/screens/random_puzzle.dart';
import 'package:mypuzzle/screens/stats.dart';

class DesktopLayout extends ConsumerStatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends ConsumerState<DesktopLayout>
    with SingleTickerProviderStateMixin {
  final List<Widget> screens = const <Widget>[
    RandomPuzzle(),
    ImportPuzzle(),
    Stats(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    final int index = ref.watch(viewIndexProvider);

    return Scaffold(
      body: Row(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 500,
                child: Container(
                  color: Colors.black,
                ),
              ),
              WavedDrawer(
                index,
                Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
            ],
          ),
          screens.elementAt(index),
        ],
      ),
    );
  }
}

class WavedDrawer extends ConsumerStatefulWidget {
  final int index;
  final Size size;
  const WavedDrawer(this.index, this.size, {Key? key}) : super(key: key);

  @override
  _WavedDrawerState createState() => _WavedDrawerState();
}

class _WavedDrawerState extends ConsumerState<WavedDrawer>
    with SingleTickerProviderStateMixin {
  late List<Offset> _points;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, upperBound: 2 * pi, duration: const Duration(seconds: 5));
    _controller.repeat();
    _initPoints();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(viewIndexProvider.notifier);
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        color: Colors.blue[100],
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(00),
              color: Colors.white,
              child: const FlutterLogo(),
            ),
            TextButton(
              onPressed: () => notifier.changeIndex(0),
              child: Text(
                'Random Puzzleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                style: TextStyle(
                    color: widget.index == 0 ? Colors.blue : Colors.black),
              ),
            )

            //   ListTile(
            //       title: Text(
            //         'Import Puzzle',
            //         style: TextStyle(
            //             color:
            //                 widget.index == 1 ? Colors.blue : Colors.black),
            //       ),
            //       onTap: () => notifier.changeIndex(1)),
            //   ListTile(
            //       title: Text(
            //         'Stats',
            //         style: TextStyle(
            //             color:
            //                 widget.index == 2 ? Colors.blue : Colors.black),
            //       ),
            //       onTap: () => notifier.changeIndex(2)),
            //   ListTile(
            //       title: Text(
            //         'About',
            //         style: TextStyle(
            //             color:
            //                 widget.index == 3 ? Colors.blue : Colors.black),
            //       ),
            //       onTap: () => notifier.changeIndex(3)),
          ],
        ),
      ),
      builder: (context, child) {
        return ClipPath(
            clipper: WaveClipper(
                controllerValue: _controller.value, points: _points),
            child: child);
      },
    );
  }

  void _initPoints() {
    _points =
        List.filled(widget.size.width.toInt(), Offset(0, widget.size.height));
  }
}

class WaveClipper extends CustomClipper<Path> {
  double controllerValue;
  List<Offset> points;

  WaveClipper({required this.controllerValue, required this.points});

  @override
  getClip(Size size) {
    Path path = Path();

    _makeSinewave(size);
    path.addPolygon(points, false);

//  la ligne du dessous marche pas
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;

  void _makeSinewave(Size size) {
    final amplitude = size.height / 16;
    final yOffset = amplitude;

    for (int x = 0; x < size.width; x++) {
      double y = amplitude * sin(x / 35 + controllerValue) + yOffset;

      Offset newPoint = Offset(x.toDouble(), y);
      points[x] = newPoint;
    }
  }
}
