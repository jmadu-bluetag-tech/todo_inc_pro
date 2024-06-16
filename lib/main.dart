import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_exports.dart';
import 'screens/todo_list.dart';
import 'services/respositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        create: (context) => TasksBloc(context.read<TodoRepository>())..add(LoadTasks()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoListPage(),
          theme: ThemeData.dark(),
        ),
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: RepositoryProvider<TodoRepository>(
    //     create: (context) => TodoRepository(),
    //     child: BlocProvider(
    //       create: (context) =>
    //           TasksBloc(RepositoryProvider.of<TodoRepository>(context)),
    //       child: TodoListPage(),
    //     ),
    //   ),
    //   // home: TodoListPage(),
    //   theme: ThemeData.dark(),
    // );
  }
}
