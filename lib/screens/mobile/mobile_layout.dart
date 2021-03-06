import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mypuzzle/providers/view_index_provider.dart';
import 'package:mypuzzle/screens/mobile/mobile_display.dart';
import 'package:mypuzzle/screens/mobile/mobile_drawer.dart';

class MobileLayout extends ConsumerStatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends ConsumerState<MobileLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final navigationKey = GlobalKey<NavigatorState>();

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

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(viewIndexProvider);

    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: [
                MobileDrawer(
                    navigationKey: navigationKey,
                    index: index,
                    controller: _controller),
                MobileDisplay(
                    navigationKey: navigationKey,
                    index: index,
                    controller: _controller),
              ],
            );
          }),
    );
  }
}
