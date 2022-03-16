import 'package:flutter/material.dart';

const josefinSans = 'Josefin Sans';

ThemeData myTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  canvasColor: Colors.blue[50],
  textTheme: const TextTheme(
    // For Move and Time texts in the board and the text in close btn when win
    bodyText1: TextStyle(
        fontFamily: josefinSans,
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.white),
    // For Reset btn in the board
    headline4: TextStyle(
        fontFamily: josefinSans,
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.blue),
    // For nums in the tiles
    headline5: TextStyle(
        fontFamily: josefinSans,
        fontWeight: FontWeight.w600,
        fontSize: 40,
        color: Colors.blue),
    // For Stats and About titles
    headline1: TextStyle(
        fontFamily: josefinSans,
        fontWeight: FontWeight.w600,
        fontSize: 56,
        color: Colors.white),
    headline6: TextStyle(
        fontFamily: josefinSans,
        fontWeight: FontWeight.w600,
        fontSize: 36,
        color: Colors.white),
  ),
);
