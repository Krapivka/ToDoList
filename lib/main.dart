import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/models/task.dart';

const tasksBox = "tasks1";

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Task>(tasksBox);
  Hive.registerAdapter(TaskAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: ToDoListApp(
        title: 'TODO List app',
      ),
    );
  }
}
