import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/task.dart';

class TaskRepository extends ChangeNotifier {
  late final Box<Task> boxTasks;
  TaskRepository() {
    boxTasks = Hive.box(tasksBox);
  }

  void addTask({required String description}) {
    int? key;
    if (boxTasks.values.isNotEmpty) {
      key = boxTasks.values.last.id + 1;
    } else {
      key = 1;
    }
    boxTasks.put(key, Task(id: key, description: description));
    debugPrint(boxTasks.values.toString());
    notifyListeners();
  }

  void deleteTask({required int id}) {
    boxTasks.delete(id);
    debugPrint(boxTasks.values.toString());
    notifyListeners();
  }

  void updateTask({required Task task, required String description}) {
    Task newTask =
        Task(id: task.id, description: description, isDone: task.isDone);
    boxTasks.put(task.id, newTask);
    debugPrint(boxTasks.values.toString());
    notifyListeners();
  }

  List<Task> getAllTasks() {
    return boxTasks.values.toList();
  }
}

final taskRepository = ChangeNotifierProvider<TaskRepository>((ref) {
  return TaskRepository();
});
