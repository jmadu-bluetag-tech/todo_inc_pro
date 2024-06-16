import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_inc_pro/model/task.dart';

import '../blocs/bloc_exports.dart';
import '../services/respositories.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: submitData,
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isEmpty || description.isEmpty) {
      showErrorMessae('Title and Description cannot be empty');
      return;
    }

    try {
      final task = Task(title: title, description: description);
      BlocProvider.of<TasksBloc>(context).add(AddTask(task: task));

      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessae('Task Created');
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      showErrorMessae('An error occurred: ${e.toString()}');
      // // Check if the error is of type Exception
      // if (e is Exception) {
      //   showErrorMessae('An error occurred: ${e.toString()}');
      // } else {
      //   showErrorMessae('An unknown error occurred');
      // }
    }
  }

  // Success message
  void showSuccessMessae(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Error message
  void showErrorMessae(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
