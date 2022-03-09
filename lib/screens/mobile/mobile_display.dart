import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/board.dart';
import 'package:mypuzzle/screens/stats.dart';

class MobileDisplay extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final int index;
  final AnimationController controller;

  const MobileDisplay(
      {required this.navigationKey,
      required this.index,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileDisplayState();
}

class _MobileDisplayState extends ConsumerState<MobileDisplay> {
  String routename() {
    if (widget.index == 0) {
      return Board.routeName;
    } else if (widget.index == 1) {
      return Stats.routeName;
    } else {
      return About.routeName;
    }
  }

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
            child: Navigator(
              key: widget.navigationKey,
              initialRoute: routename(),
              onGenerateRoute: (RouteSettings routeSettings) {
                switch (routeSettings.name) {
                  case Board.routeName: // '/board'
                    return MaterialPageRoute(
                        builder: (context) => const Board());
                  case Stats.routeName: // '/stats'
                    return MaterialPageRoute(
                        builder: (context) => const Stats());
                  case About.routeName: // '/about'
                    return MaterialPageRoute(
                        builder: (context) => const About());
                  default:
                    return MaterialPageRoute(
                      builder: (context) => const Scaffold(
                        body: Center(
                          child: Text('Page not found'),
                        ),
                      ),
                    );
                }
              },
            ),
          ),
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
        title: Text(
          // TODO: change font
          'Water Puzzle',
          style: TextStyle(
              color:
                  widget.controller.value > 0.5 ? Colors.white : Colors.blue),
        ),
        centerTitle: true,
      ),
    );
  }

  void toggle() => widget.controller.isDismissed
      ? widget.controller.forward()
      : widget.controller.reverse();
}
