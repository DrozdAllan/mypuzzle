import 'package:hive_flutter/hive_flutter.dart';
import 'package:mypuzzle/models/stat.dart';

class HiveDb {
  static Box? statBox;

  static Future<void> init() async {
    Hive.initFlutter();

    Hive.registerAdapter(StatAdapter());

    statBox = await Hive.openBox('StatBox');
  }
}
