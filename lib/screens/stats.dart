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
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 54.0),
        child: Text(
          "Your previous puzzles",
          style: isMobile
              ? Theme.of(context).textTheme.headline6
              : Theme.of(context).textTheme.headline1,
        ),
      ),
      Expanded(
        child: ValueListenableBuilder(
          valueListenable: box!.listenable(),
          builder: (context, Box box, _) {
            List stats = box.values.toList().reversed.toList();
            if (stats.isEmpty) {
              return const Text(
                'You don\'t have any previous game in your historic',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center,
              );
            } else {
              return Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: stats.length,
                  itemBuilder: (BuildContext context, int listIndex) {
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 18.0),
                      title: Text(
                        DateFormat.yMd().add_Hm().format(stats[listIndex].date),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        'This puzzle was resolved in ' +
                            stats[listIndex].time.toString() +
                            ' seconds and ' +
                            stats[listIndex].moves.toString() +
                            ' moves',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    ]);
  }
}
