import 'package:flutter/material.dart';
import 'package:mypuzzle/database/hive_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  static const routeName = '/stats';

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  var box = HiveDb.statBox;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text("Your previous puzzles"),
      ),
      SizedBox(
        width: 500,
        height: 500,
        child: ValueListenableBuilder(
          valueListenable: box!.listenable(),
          builder: (context, Box box, _) {
            List stats = box.values.toList();
            return ListView.builder(
              itemCount: stats.length,
              itemBuilder: (BuildContext context, int listIndex) {
                return ListTile(
                  title: Text(stats[listIndex].date.toIso8601String()),
                  subtitle: Text('This puzzle was resolved in ' +
                      stats[listIndex].time.toString() +
                      ' seconds and ' +
                      stats[listIndex].moves.toString() +
                      ' moves'),
                );
              },
            );
          },
        ),
      ),
    ]);
  }
}
