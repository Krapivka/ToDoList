import 'dart:isolate';

import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({required this.description, this.isDone = false});
  @HiveField(0)
  final String description;
  @HiveField(1)
  bool isDone;
  @override
  String toString() {
    return '$description';
  }
}
