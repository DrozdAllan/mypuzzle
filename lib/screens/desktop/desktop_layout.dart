import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/board.dart';
import 'package:mypuzzle/screens/home.dart';
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
    Stats(),
    About(),
    Board(),
  ];

  @override
  Widget build(BuildContext context) {
    final int index = ref.watch(viewIndexProvider);
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Row(
        children: [
          WavedDrawer(
            index,
            Size(300.0, MediaQuery.of(context).size.height),
          ),
          Expanded(child: screens.elementAt(index)),
        ],
      ),
    );
  }
}

// TODO: add more smooth style to the wave
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
        vsync: this, upperBound: 2 * pi, duration: const Duration(seconds: 1));
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
        // impératif de donner une taille au child que tu clip
        width: widget.size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const FlutterLogo(
              size: 64.0,
            ),
            TextButton(
              onPressed: () {
                _controller.forward().whenComplete(() => _controller.reset());
                notifier.changeIndex(0);
              },
              child: Text(
                'Game',
                style: TextStyle(
                    color: widget.index == 0 ? Colors.blue : Colors.black,
                    fontSize: 34.0),
              ),
            ),
            TextButton(
              onPressed: () {
                _controller.forward().whenComplete(() => _controller.reset());
                notifier.changeIndex(1);
              },
              child: Text(
                'Stats',
                style: TextStyle(
                    color: widget.index == 1 ? Colors.blue : Colors.black,
                    fontSize: 34.0),
              ),
            ),
            TextButton(
              onPressed: () {
                _controller.forward().whenComplete(() => _controller.reset());
                notifier.changeIndex(2);
              },
              child: Text(
                'About',
                style: TextStyle(
                    color: widget.index == 2 ? Colors.blue : Colors.black,
                    fontSize: 34.0),
              ),
            ),
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
        List.filled(widget.size.height.toInt(), Offset(0, widget.size.width));
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

    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;

  void _makeSinewave(Size size) {
    final amplitude = size.width / 16;
    final xOffset = amplitude;

    for (int x = 0; x < size.height.toInt(); x++) {
      double y = amplitude * sin(x / 35 + controllerValue) + xOffset;

      Offset newPoint = Offset(size.width * 0.85 + y.toDouble(), x.toDouble());
      points[x] = newPoint;
    }
  }
}
