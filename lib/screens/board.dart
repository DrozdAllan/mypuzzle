import 'dart:async';
import 'dart:developer' as Dev;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mypuzzle/widgets/grid.dart';
import 'package:mypuzzle/widgets/menu.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/models/tile.dart';

class Board extends ConsumerStatefulWidget {
  const Board({Key? key}) : super(key: key);

  static const routeName = '/game';

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(width: 100, height: 100, child: Placeholder()),
          SizedBox(width: 100, height: 100, child: Placeholder()),
        ],
      ),
      const _BoardGrid(),
    ]);
  }
}

class _BoardGrid extends ConsumerStatefulWidget {
  const _BoardGrid({
    Key? key,
  }) : super(key: key);

  @override
  __BoardGridState createState() => __BoardGridState();
}

class __BoardGridState extends ConsumerState<_BoardGrid> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    timer ??= timer = Timer.periodic(duration, (Timer t) {
      startTime();
    });

    return SafeArea(
      child: Container(
        height: size.height,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Text(
              "Sliding Puzzle",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.050,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            Grid(numbers: numbers, size: size, clickGrid: clickGrid),
            Menu(
                reset: reset,
                move: move,
                secondsPassed: secondsPassed,
                size: size),
          ],
        ),
      ),
    );
  }

  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
