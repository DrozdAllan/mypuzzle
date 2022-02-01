import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/provider/view_index_provider.dart';
import 'package:mypuzzle/screens/about.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(viewIndexProvider);
    final notifier = ref.read(viewIndexProvider.notifier);
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            double slide = 250.0 * _controller.value;
            double scale = 1 - (_controller.value * 0.3);
            return Stack(
              children: [
                myCustomDrawer(index, notifier),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            onPressed: () {
                              toggle();
                            },
                            icon: const Icon(Icons.bubble_chart)),
                      ),
                      body: screens.elementAt(index)),
                )
              ],
            );
          }),
    );
  }

  myCustomDrawer(int index, ViewIndexProvider notifier) {
    return Scaffold(
      body: Container(
        color: Colors.blue[50],
        child: ListView(
          children: [
            Container(
              height: 100,
              width: 50,
              color: Colors.grey,
              child: const Center(child: Text('Logo or Big Title')),
            ),
            ListTile(
              title: Text(
                'Random Puzzle',
                style:
                    TextStyle(color: index == 0 ? Colors.blue : Colors.black),
              ),
              onTap: () {
                toggle();

                notifier.changeIndex(0);
              },
            ),
            ListTile(
              title: Text(
                'Import Puzzle',
                style:
                    TextStyle(color: index == 1 ? Colors.blue : Colors.black),
              ),
              onTap: () {
                toggle();

                notifier.changeIndex(1);
              },
            ),
            ListTile(
              title: Text(
                'Stats',
                style:
                    TextStyle(color: index == 2 ? Colors.blue : Colors.black),
              ),
              onTap: () {
                toggle();

                notifier.changeIndex(2);
              },
            ),
            ListTile(
              title: Text(
                'About',
                style:
                    TextStyle(color: index == 3 ? Colors.blue : Colors.black),
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
