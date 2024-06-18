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
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TasksErrorState) {
            return Center(child: Text(state.message));
          } else if (state is TasksLoadedState) {
            if (state.allTasks.isEmpty) {
              return Center(child: const Text('No tasks available.'));
            }

            return ListView.builder(
              itemCount: state.allTasks.length,
              itemBuilder: (context, index) {
                final task = state.allTasks[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      task.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      navigateToTaskView(task.id);
                    },
                    trailing: PopupMenuButton(
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              child: TextButton.icon(
                                onPressed: () {
                                  navigateToEditPage(task.id);
                                },
                                label: const Text('Edit'),
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                            PopupMenuItem(
                              child: TextButton.icon(
                                onPressed: () {
                                  _deleteTask(task);
                                },
                                label: const Text('Delete'),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add Todo '),
      ),
    );
  }

  void navigateToTaskView(String taskId) async {
    try {
      final taskData = await todoRepository.fetchTodoById(taskId);
      final route = MaterialPageRoute(
        builder: (context) => TaskView(taskData: taskData),
      );
      Navigator.push(context, route);
    } catch (e) {
      print('Error fetching task: $e');
    }
  }

  void navigateToEditPage(String taskId) async {
    final task = await todoRepository.fetchTodoById(taskId);
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(
        task: task,
        isEditMode: true,
      ),
    );
    Navigator.pop(context);
    Navigator.push(context, route);
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  void _deleteTask(Task task) async {
    try {
      await todoRepository.deleteTaskById(task.id);
      BlocProvider.of<TasksBloc>(context).add(DeleteTask(task: task));
      Navigator.pop(context);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
