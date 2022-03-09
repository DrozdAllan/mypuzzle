import 'package:flutter/material.dart';
import 'package:mypuzzle/screens/desktop/desktop_layout.dart';
import 'package:mypuzzle/screens/mobile/mobile_layout.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _Wrapper createState() => _Wrapper();
}

class _Wrapper extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 750) {
          return const DesktopLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
