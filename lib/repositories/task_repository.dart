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
    boxTasks.put(boxTasks.length + 1,
        Task(id: boxTasks.length + 1, description: description));
    notifyListeners();
  }

  void deleteTask({required int id}) {
    boxTasks.delete(id);
    notifyListeners();
  }

  void updateTask({required Task task, required String description}) {
    Task newTask =
        Task(id: task.id, description: description, isDone: task.isDone);
    boxTasks.put(task.id, newTask);
    notifyListeners();
  }

  List<Task> getAllTasks() {
    return boxTasks.values.toList();
  }
}

final taskRepository = ChangeNotifierProvider<TaskRepository>((ref) {
  return TaskRepository();
});
