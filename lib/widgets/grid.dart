import 'package:flutter/material.dart';
import 'package:mypuzzle/widgets/grid_button.dart';

class Grid extends StatelessWidget {
  final List numbers;
  final Size size;
  final Function clickGrid;

  const Grid(
      {Key? key,
      required this.numbers,
      required this.size,
      required this.clickGrid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return SizedBox(
      height: height * 0.60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? GridButton(text: "$numbers[index]", click: clickGrid(index))
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
