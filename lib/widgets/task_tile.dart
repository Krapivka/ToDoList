import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  TaskTile({super.key, required this.description, required this.isDone});
  final String description;
  bool isDone;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      width: MediaQuery.of(context).size.width - 10,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(widget.description),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.isDone = !widget.isDone;
                  });
                },
                icon: widget.isDone
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank_rounded))
          ],
        ),
      ),
    );
  }
}
