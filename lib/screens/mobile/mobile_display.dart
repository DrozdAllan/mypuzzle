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
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlueAccent,
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
              widget.controller.isDismissed
                  ? Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                      child: AnimatedButton(controller: widget.controller),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final AnimationController controller;

  const AnimatedButton({Key? key, required this.controller}) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        toggle();
      },
      mini: true,
      backgroundColor: Colors.blue[50],
      child: const Icon(
        Icons.menu_rounded,
        color: Colors.blue,
      ),
    );
  }

  void toggle() => widget.controller.isDismissed
      ? widget.controller.forward()
      : widget.controller.reverse();
}
