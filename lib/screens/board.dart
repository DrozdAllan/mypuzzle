import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mypuzzle/models/stat.dart';
import 'package:mypuzzle/services/database_service.dart';

class Board extends ConsumerStatefulWidget {
  const Board({Key? key}) : super(key: key);

  static const routeName = '/board';

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  List<int> numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
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
      color: Colors.lightBlueAccent,
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: isMobile ? size.width * 0.30 : size.width * 0.10,
                    child: Text(
                      "Move : $move",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    width: isMobile ? size.width * 0.30 : size.width * 0.10,
                    child: Text(
                      "Time : $secondsPassed s",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[50]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Reset",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // size of the board
            height: isMobile ? size.height * 0.60 : size.height * 0.75,
            width: isMobile ? size.width * 0.75 : size.width * 0.35,
            padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                              MaterialStateProperty.all(Colors.blue[50]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          clickGrid(index);
                        },
                        child: Text(
                          numbers[index].toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
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
      // register move and time in stats
      var stat = Stat(moves: move, time: secondsPassed, date: DateTime.now());
      DatabaseService().addToBox(stat);
      isActive = false;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: 120,
              width: 400,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animations/confetti-left.json',
                          width: 75, height: 75, fit: BoxFit.fill),
                      const Text(
                        "Congratulations, you win !",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Lottie.asset('assets/animations/confetti-right.json',
                          width: 75, height: 75, fit: BoxFit.fill),
                    ],
                  ),
                  SizedBox(
                    width: 220.0,
                    height: 30.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.lightBlueAccent)),
                      onPressed: () {
                        Navigator.pop(context);
                        reset();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Close",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
