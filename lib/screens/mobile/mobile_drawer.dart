import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mypuzzle/providers/view_index_provider.dart';

class MobileDrawer extends ConsumerStatefulWidget {
  final int index;
  final AnimationController controller;

  const MobileDrawer({
    required this.index,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _MobileDrawerState createState() => _MobileDrawerState();
}

class _MobileDrawerState extends ConsumerState<MobileDrawer> {
  void toggle() => widget.controller.isDismissed
      ? widget.controller.forward()
      : widget.controller.reverse();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(viewIndexProvider.notifier);

    return AnimatedBuilder(
        animation: widget.controller,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const FlutterLogo(
                size: 80.0,
              ),
              ListTile(
                title: Text(
                  'Random Puzzle',
                  style: TextStyle(
                      color: widget.index == 0 ? Colors.blue : Colors.black),
                ),
                onTap: () {
                  toggle();

                  notifier.changeIndex(0);
                },
              ),
              ListTile(
                title: Text(
                  'Import Puzzle',
                  style: TextStyle(
                      color: widget.index == 1 ? Colors.blue : Colors.black),
                ),
                onTap: () {
                  toggle();

                  notifier.changeIndex(1);
                },
              ),
              ListTile(
                title: Text(
                  'Stats',
                  style: TextStyle(
                      color: widget.index == 2 ? Colors.blue : Colors.black),
                ),
                onTap: () {
                  toggle();

                  notifier.changeIndex(2);
                },
              ),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                      color: widget.index == 3 ? Colors.blue : Colors.black),
                ),
                onTap: () {
                  toggle();

                  notifier.changeIndex(3);
                },
              ),
            ],
          ),
        ),
        builder: (context, child) {
          return CustomPaint(
              painter: ClosingWave(controller: widget.controller),
              child: child);
        });
  }
}

class ClosingWave extends CustomPainter {
  final AnimationController controller;
  ClosingWave({
    required this.controller,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final myPaint = Paint()
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.blue[200]!
      ..style = PaintingStyle.fill;

    final Rect myRect = Offset(175.0 * controller.value, 0.0) &
        Size(size.width * 5, size.height);

    final myPath = Path()
      ..addRRect(RRect.fromRectAndRadius(myRect, const Radius.circular(120.0)));

    canvas.drawPath(myPath, myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
