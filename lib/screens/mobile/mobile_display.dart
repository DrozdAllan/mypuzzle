import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/board.dart';
import 'package:mypuzzle/screens/home.dart';
import 'package:mypuzzle/screens/stats.dart';

class MobileDisplay extends ConsumerStatefulWidget {
  final int index;
  final AnimationController controller;

  const MobileDisplay({required this.index, required this.controller, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileDisplayState();
}

class _MobileDisplayState extends ConsumerState<MobileDisplay> {
  final List<Widget> screens = const <Widget>[
    RandomPuzzle(),
    Stats(),
    About(),
    Board(),
  ];

  void toggle() => widget.controller.isDismissed
      ? widget.controller.forward()
      : widget.controller.reverse();

  @override
  Widget build(BuildContext context) {
    double slide = 175.0 * widget.controller.value;
    double scale = 1 - (widget.controller.value * 0.2);
    return Transform(
      transform: Matrix4.identity()
        ..translate(slide)
        ..scale(scale),
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0 * widget.controller.value),
            bottomLeft: Radius.circular(100.0 * widget.controller.value)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: widget.controller.value > 0.4
                ? Colors.blue[200]
                : Colors.blue[50],
            elevation: widget.controller.value > 0.4 ? 0.0 : 4.0,
            leading: widget.controller.value > 0.4
                ? null
                : IconButton(
                    onPressed: () {
                      toggle();
                    },
                    icon: Icon(
                      Icons.bubble_chart,
                      color: Colors.blue[200],
                    )),
          ),
          body: Container(
              color: Colors.blue[200], child: screens.elementAt(widget.index)),
        ),
      ),
    );
  }
}
