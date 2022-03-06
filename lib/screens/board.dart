import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/models/tile.dart';

class Board extends ConsumerStatefulWidget {
  const Board({Key? key}) : super(key: key);

  static const routeName = '/game';

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  List<int> numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
// TODO: maybe if you want more pieces board : https://www.youtube.com/watch?v=fDj6Eu-5oZE
  int move = 0;

  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // TODO: reenable the shuffle when finished
    // numbers.shuffle();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageCache!.clear();
    imageCache!.clearLiveImages();
    Size size = MediaQuery.of(context).size;
    bool isMobile =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    timer ??= timer = Timer.periodic(duration, (Timer t) {
      startTime();
    });

    return Container(
      height: size.height,
      color: Colors.blue[200],
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.10,
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    reset();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: const Text("Reset"),
                ),
                Text(
                  "Move : $move",
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 18),
                ),
                Text(
                  "Time : $secondsPassed",
                  style: const TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.80,
            width: isMobile ? size.width * 0.75 : size.width * 0.35,
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return numbers[index] != 0
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          clickGrid(index);
                        },
                        child: Text(numbers[index].toString()),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 <= 8 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 <= 8 && numbers[index + 3] == 0)) {
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

  bool isSorted(List numbers) {
    int prev = numbers.first;
    for (var i = 1; i < numbers.length - 1; i++) {
      int next = numbers[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      // TODO: register move and time in stats
      isActive = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // TODO: better style the victory dialog
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
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
        },
      );
    }
  }
}
