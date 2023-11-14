import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/models/task.dart';

class TaskTile extends StatefulWidget {
  TaskTile(
      {super.key,
      required this.description,
      required this.isDone,
      required this.listIndex,
      required this.box});
  final Box<Task> box;
  final int listIndex;
  final String description;
  bool isDone;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late TextEditingController controllerUpdateField;
  @override
  void initState() {
    controllerUpdateField = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text(widget.description),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    final Task tempTask = Task(
                        description: controllerUpdateField.text,
                        isDone: !widget.isDone);
                    widget.box.putAt(widget.listIndex, tempTask);
                  });
                },
                icon: widget.isDone
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank_rounded))
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
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
                final Task tempTask = Task(
                    description: controllerUpdateField.text,
                    isDone: widget.isDone);
                setState(() {
                  widget.box.putAt(widget.listIndex, tempTask);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
