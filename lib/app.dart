import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/repositories/task_repository.dart';
import 'package:todo_list/widgets/task_tile.dart';

// ignore: must_be_immutable
class ToDoListApp extends ConsumerWidget {
  ToDoListApp({super.key, required this.title});
  final String title;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskRep = ref.watch(taskRepository);
    final tasks = taskRep.getAllTasks();
    print(taskRep.boxTasks.values);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(title),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ValueListenableBuilder(
            valueListenable: taskRep.boxTasks.listenable(),
            builder: (context, Box<Task> box, _) {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, id) {
                  Task? task = tasks[id];
                  return TaskTile(
                    task: task,
                  );
                },
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 100,
            color: Colors.white30,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: 62,
                  width: MediaQuery.of(context).size.width * 7.4 / 10,
                  child: Card(
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your task'),
                      controller: controller,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    taskRep.addTask(description: controller.text);
                  },
                  tooltip: 'Add task',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
