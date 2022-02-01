import 'package:flutter/material.dart';
import 'package:mypuzzle/breakpoints.dart';
import 'package:mypuzzle/screens/desktop/home_desktop.dart';
import 'package:mypuzzle/screens/mobile/home_mobile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= desktopBreakpoint) {
          return const HomeDesktop();
        } else {
          return const HomeMobile();
        }
      },
    );
  }
}
