import 'package:flutter/material.dart';
import 'package:mypuzzle/models/user_id.dart';
import 'package:mypuzzle/screens/reception.dart';

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
        if (constraints.maxWidth >= 600) {
          return const DesktopLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Text('Mobile Version'),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Reception.routeName,
              arguments: UserID(id: 'zinzin'),
            ),
            child: const Text('Go to reception'),
          ),
        ],
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 3.0, color: Colors.lightBlue),
                ),
              ),
              child: Column(
                children: [
                  const Text('Welcome to the puzzle challenge !'),
                  const Text('Desktop version'),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Reception.routeName,
                      arguments: UserID(id: 'zinzin'),
                    ),
                    child: const Text('Go to reception'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  children: [
                    const Text('Welcome to the puzzle challenge !'),
                    const Text('Desktop version'),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Reception.routeName,
                        arguments: UserID(id: 'zinzin'),
                      ),
                      child: const Text('Go to reception'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
