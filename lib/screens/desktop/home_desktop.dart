import 'package:flutter/material.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          width: 250,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 3.0, color: Colors.lightBlue),
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Container(
                    padding: const EdgeInsets.all(00),
                    color: Colors.grey,
                    child: Text('Logo'),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListTile(
                      title: const Text('Random Puzzle'),
                      onTap: () => null,
                    ),
                    ListTile(
                      title: const Text('Import my Puzzle'),
                      onTap: () => null,
                    ),
                    ListTile(
                      title: const Text('My Stats'),
                      onTap: () => null,
                    ),
                    ListTile(
                      title: const Text('About'),
                      onTap: () => null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Column(
              children: const [
                Text('Welcome to the puzzle challenge !'),
                Text('Desktop version'),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
