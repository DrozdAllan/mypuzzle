import 'dart:developer';

class Tile {
  final int xPosition;
  final int yPosition;
  final String status;

  Tile(
      {required this.xPosition, required this.yPosition, required this.status});

  set xPosition(int newXPosition) {
    xPosition = newXPosition;
  }

  set yPosition(int newYPosition) {
    yPosition = newYPosition;
  }

  set status(String newStatus) {
    status = newStatus;
  }
}
