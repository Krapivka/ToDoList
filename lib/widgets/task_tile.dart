import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/repositories/task_repository.dart';

class TaskTile extends ConsumerStatefulWidget {
  const TaskTile({super.key, required this.task});
  final Task task;
  @override
  TaskTileState createState() => TaskTileState();
}

class TaskTileState extends ConsumerState<TaskTile> {
  late TextEditingController controllerUpdateField;
  @override
  void initState() {
    controllerUpdateField =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskRep = ref.watch(taskRepository);
    return Dismissible(
        key: Key(widget.task.id.toString()),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          width: MediaQuery.of(context).size.width - 10,
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _dialogBuilder(context);
                    });
                  },
                  child: Text(widget.task.description),
                ),
                IconButton(
                    onPressed: () {
                      setState(() async {
                        final Task tempTask = Task(
                            description: controllerUpdateField.text,
                            isDone: !widget.task.isDone,
                            id: widget.task.id);
                        taskRep.updateTask(
                            task: tempTask,
                            description: controllerUpdateField.text);
                      });
                    },
                    icon: widget.task.isDone
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank_rounded))
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          taskRep.deleteTask(id: widget.task.id);
        });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final taskRep = ref.watch(taskRepository);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit a task'),
          content: TextField(
            controller: controllerUpdateField,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                taskRep.updateTask(
                    task: widget.task, description: controllerUpdateField.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
