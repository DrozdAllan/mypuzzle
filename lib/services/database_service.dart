import 'package:mypuzzle/models/stat.dart';

import '../database/hive_db.dart';

class DatabaseService {
  addToBox(Stat stat) async {
    HiveDb.statBox!.add(stat);
  }
}
