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

  List<Tile> tileSet = [
    Tile(correctPosition: 0, imagePath: 'puzzles/frodondejardin/easy/00.png'),
    Tile(correctPosition: 1, imagePath: 'puzzles/frodondejardin/easy/01.png'),
    Tile(correctPosition: 2, imagePath: 'puzzles/frodondejardin/easy/02.png'),
    Tile(correctPosition: 3, imagePath: 'puzzles/frodondejardin/easy/03.png'),
    Tile(correctPosition: 4, imagePath: 'puzzles/frodondejardin/easy/04.png'),
    Tile(correctPosition: 5, imagePath: 'puzzles/frodondejardin/easy/05.png'),
    Tile(correctPosition: 6, imagePath: 'puzzles/frodondejardin/easy/06.png'),
    Tile(correctPosition: 7, imagePath: 'puzzles/frodondejardin/easy/07.png'),
    Tile(correctPosition: 8, imagePath: 'puzzles/frodondejardin/easy/08.png'),
  ];

  int move = 0;

  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // numbers.shuffle();
    tileSet.shuffle();
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Move: $move",
                    style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Time: $secondsPassed",
                    style: const TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
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
              //   itemCount: numbers.length,
              itemCount: tileSet.length,
              itemBuilder: (context, index) {
                return numbers[index] != 0
                    // TODO: LATER !!! replace 0 with rand(9) to change the piece being removed
                    // tileSet[index].correctPosition != 0
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
                        // TODO: change this to be images
                        child: Text(numbers[index].toString()),
                        //     Image.asset(
                        //   tileSet[index].imagePath,
                        //   height: 150.0,
                        //   fit: BoxFit.fill,
                        // ),
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
    inspect(tileSet);
    if (secondsPassed == 0) {
      isActive = true;
    }
    // if (index - 1 >= 0 &&
    //         tileSet[index - 1].correctPosition == 0 &&
    //         index % 3 != 0 ||
    //     index + 1 <= 8 &&
    //         tileSet[index + 1].correctPosition == 0 &&
    //         (index + 1) % 3 != 0 ||
    //     (index - 3 >= 0 && tileSet[index - 3].correctPosition == 0) ||
    //     (index + 3 <= 8 && tileSet[index + 3].correctPosition == 0)) {
    //   setState(() {
    //     move++;
    //     // TODO: use indexOf or another method to retrieve the index of the Tile being correctPosition: 0
    //     tileSet[tileSet.indexOf(Tile(correctPosition: 0))].correctPosition =
    //         tileSet[index].correctPosition;
    //     tileSet[index].correctPosition = 0;
    //   });
    // }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 <= 8 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 <= 8 && numbers[index + 3] == 0)) {
      setState(() {
        move++;
        // TODO: indexOf will search for the index of the element being 0
        numbers[numbers.indexOf(0)] = numbers[index];
        // numbers[numbers.indexOf(0)] = numbers[index];
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

  bool isSorted(List<Tile> list) {
    int prev = list.first.correctPosition;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i].correctPosition;
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(tileSet)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
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
          });
    }
  }
}
