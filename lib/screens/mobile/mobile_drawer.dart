import 'dart:ui';

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
    final Size siza = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return CustomPaint(
      painter: ClosingWave(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.blue[50],
        child: ListView(
          children: [
            const FlutterLogo(
              size: 50.0,
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
    );
  }
}

class ClosingWave extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final myPaint = Paint()
      ..strokeWidth = 40.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    final Rect myRect =
        Offset(size.width / 2, 0.0) & Size(size.width, size.height);

    canvas.drawOval(myRect, myPaint);
    // canvas.drawArc(Rect.largest, 0.0, 90.0, true, myPaint);
    // canvas.drawPoints(PointMode.polygon, points, myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
