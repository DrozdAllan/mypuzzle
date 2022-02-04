import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mypuzzle/providers/view_index_provider.dart';
import 'package:mypuzzle/screens/about.dart';
import 'package:mypuzzle/screens/game.dart';
import 'package:mypuzzle/screens/import_puzzle.dart';
import 'package:mypuzzle/screens/random_puzzle.dart';
import 'package:mypuzzle/screens/stats.dart';

class MobileLayout extends ConsumerStatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends ConsumerState<MobileLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() =>
      _controller.isDismissed ? _controller.forward() : _controller.reverse();

  final List<Widget> screens = const <Widget>[
    RandomPuzzle(),
    ImportPuzzle(),
    Stats(),
    About(),
    Game(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(viewIndexProvider);
    final notifier = ref.read(viewIndexProvider.notifier);
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            double slide = 175.0 * _controller.value;
            double scale = 1 - (_controller.value * 0.2);
            return Stack(
              children: [
                myCustomDrawer(index, notifier),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0 * _controller.value),
                        bottomLeft: Radius.circular(100.0 * _controller.value)),
                    // clipper: MyClipper(controllerValue: _controller.value),
                    child: Scaffold(
                        // backgroundColor: Colors.blue[200],
                        appBar: AppBar(
                          backgroundColor: Colors.blue[50],
                          leading: IconButton(
                              onPressed: () {
                                toggle();
                              },
                              icon: const Icon(Icons.bubble_chart)),
                        ),
                        body: Container(
                            color: Colors.blue[200],
                            child: screens.elementAt(index))),
                  ),
                )
              ],
            );
          }),
    );
  }

  myCustomDrawer(int index, ViewIndexProvider notifier) {
    return Container(
      color: Colors.blue[50],
      child: ListView(
        children: [
          const FlutterLogo(
            size: 50.0,
          ),
          ListTile(
            title: Text(
              'Random Puzzle',
              style: TextStyle(color: index == 0 ? Colors.blue : Colors.black),
            ),
            onTap: () {
              toggle();

              notifier.changeIndex(0);
            },
          ),
          ListTile(
            title: Text(
              'Import Puzzle',
              style: TextStyle(color: index == 1 ? Colors.blue : Colors.black),
            ),
            onTap: () {
              toggle();

              notifier.changeIndex(1);
            },
          ),
          ListTile(
            title: Text(
              'Stats',
              style: TextStyle(color: index == 2 ? Colors.blue : Colors.black),
            ),
            onTap: () {
              toggle();

              notifier.changeIndex(2);
            },
          ),
          ListTile(
            title: Text(
              'About',
              style: TextStyle(color: index == 3 ? Colors.blue : Colors.black),
            ),
            onTap: () {
              toggle();

              notifier.changeIndex(3);
            },
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final double controllerValue;

  MyClipper({
    required this.controllerValue,
  });

  @override
  getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width, size.height * 15 / 100)
      ..quadraticBezierTo(
          -500, size.height / 2, size.width, size.height * 85 / 100)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
