import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  static const routeName = '/stats';

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('stats'),
    );
  }
}