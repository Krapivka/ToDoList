import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({required this.id, required this.description, this.isDone = false});
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool isDone;
  @override
  String toString() {
    return '$description';
  }
}
