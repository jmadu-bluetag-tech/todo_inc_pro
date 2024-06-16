import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/task.dart';

import '../../services/respositories.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TodoRepository _todoRepository;
  TasksBloc(this._todoRepository) : super(const TasksState()) {
    on<LoadTasks>(_onLoadTasks);

    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    try {
      final tasks = await _todoRepository.fetchTask();
      emit(TasksState(allTasks: tasks));
    } catch (e) {
      // Handle error
      print('Error fetching tasks: $e');
    }
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    try {
      final newTask = await _todoRepository.createTask(
          event.task.title, event.task.description);
      final updatedTasks = List<Task>.from(state.allTasks)..add(newTask);
      emit(TasksState(allTasks: updatedTasks));
    } catch (e) {
      // Handle error
      print('Error adding task: $e');
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {}

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {}
}
