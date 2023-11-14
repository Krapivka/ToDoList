import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/task_tile.dart';

// ignore: must_be_immutable
class ToDoListApp extends StatefulWidget {
  ToDoListApp({super.key, required this.title});
  final String title;

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  late Box<Task> box;
  List<Task> tasks = [
    Task(description: "1 задача"),
  ];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    box = Hive.box(tasksBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box<Task> box, _) {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, listIndex) {
                  Task task = box.get(listIndex)!;
                  return TaskTile(
                    box: box,
                    listIndex: listIndex,
                    description: task.description,
                    isDone: task.isDone,
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
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(18),
                  //   color: Theme.of(context).colorScheme.onInverseSurface,
                  // ),
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 15,
                  // ),
                  margin: const EdgeInsets.all(15),
                  height: 62,
                  width: MediaQuery.of(context).size.width * 7.4 / 10,
                  child: Card(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your task'),
                      controller: controller,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      box.add(Task(description: controller.text));
                    });
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
