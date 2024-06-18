import 'package:flutter/material.dart';
import 'package:todo_inc_pro/model/task.dart';
import 'package:todo_inc_pro/services/respositories.dart';

class TaskView extends StatefulWidget {
  final Task? taskData;

  TaskView({
    super.key,
    required this.taskData,
  });

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  // Future<Task>? taskDataFuture;
  // final TodoRepository todoRepository = TodoRepository();

  // @override
  // void initState() {
  //   super.initState();
  //   taskDataFuture = todoRepository.fetchTodoById(widget.taskID);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.taskData != null) {
  //     // Task data provided in constructor
  //     taskDataFuture = Future.value(widget.taskData); // Wrap in a Future
  //   } else {
  //     taskDataFuture = todoRepository.fetchTodoById(widget.taskID);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Task? taskData = widget.taskData; // Use provided task data

    if (taskData == null) {
      // Handle case where no task data is provided (optional)
      return Center(child: Text('No task data available'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskData.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(taskData.description),
          ],
        ),
      ),
    );
  }
}
