import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/board.dart';
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
    Board(),
    Stats(),
    About(),
  ];

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
          appBar: AnimatedAppBar(controller: widget.controller),
          body: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue[200],
              child: screens.elementAt(widget.index)),
        ),
      ),
    );
  }
}

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AnimationController controller;

  const AnimatedAppBar({Key? key, required this.controller}) : super(key: key);

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _AnimatedAppBarState extends State<AnimatedAppBar> {
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _colorTween = ColorTween(begin: Colors.blue[50], end: Colors.blue[200])
        .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => AppBar(
        backgroundColor: _colorTween.value,
        elevation: widget.controller.value > 0.5 ? 0.0 : 4.0,
        leading: widget.controller.value > 0.5
            ? null
            : IconButton(
                onPressed: () {
                  toggle();
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.blue,
                ),
                splashRadius: 25.0,
              ),
      ),
    );
  }

  void toggle() => widget.controller.isDismissed
      ? widget.controller.forward()
      : widget.controller.reverse();
}
