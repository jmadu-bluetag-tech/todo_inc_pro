import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_inc_pro/model/task.dart';

import '../blocs/bloc_exports.dart';
import '../services/respositories.dart';
import 'add_page.dart';
import 'task_view.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoRepository todoRepository = TodoRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Inc Pro'),
      ),
      body: BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
        
        if (state.allTasks.isEmpty) {
          return Center(child: Text('No tasks available.'));
        }
        return ListView.builder(
          itemCount: state.allTasks.length,
          itemBuilder: (context, index) {
            void navigateToTaskView() async {
              final String taskId =
                  state.allTasks[index].id; // Get task ID from current task
              final selectedTask = await todoRepository.fetchTodoById(taskId);
              final route = MaterialPageRoute(
                  builder: (context) => TaskView(taskData: selectedTask));
              Navigator.push(context, route);
            }

            final task = state.allTasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              onTap: () {
                navigateToTaskView();
              },
              trailing: Icon(Icons.delete),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add Todo '),
      ),
    );
  }

  // void navigateToTaskView() {
  //   // Fetch taskData data using fetchTodoById
  //   taskData = todoRepository.fetchTodoById(taskID);
  //   final route = MaterialPageRoute(builder: (context) => TaskView());
  //   Navigator.push(context, route);
  // }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }
}
