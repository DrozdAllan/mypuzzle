import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        child: Text(
          "Your previous puzzles",
          style: TextStyle(color: Colors.white, fontSize: 36.0),
        ),
      ),
      SizedBox(
        width: 500,
        height: 500,
        child: ValueListenableBuilder(
          valueListenable: box!.listenable(),
          builder: (context, Box box, _) {
            List stats = box.values.toList().reversed.toList();
            return ListView.builder(
              itemCount: stats.length,
              itemBuilder: (BuildContext context, int listIndex) {
                return ListTile(
                  title: Text(
                    DateFormat.yMd().add_Hm().format(stats[listIndex].date),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  subtitle: Text(
                    'This puzzle was resolved in ' +
                        stats[listIndex].time.toString() +
                        ' seconds and ' +
                        stats[listIndex].moves.toString() +
                        ' moves',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              },
            );
          },
        ),
      ),
    ]);
  }
}
