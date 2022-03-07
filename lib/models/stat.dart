import 'package:hive/hive.dart';

part 'stat.g.dart';

@HiveType(typeId: 0)
class Stat extends HiveObject {
  @HiveField(0)
  final int moves;
  @HiveField(1)
  final int time;
  @HiveField(2)
  final DateTime date;

  Stat({required this.moves, required this.time, required this.date});
}
