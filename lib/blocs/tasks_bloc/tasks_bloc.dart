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
    emit(TasksLoadingState());

    try {
      final tasks = await _todoRepository.fetchTask();
      emit(TasksState(allTasks: tasks));
    } catch (e) {
      // Handle error
      print('Error fetching tasks: $e');
    }
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
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

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      // Update the task in the database
      final updatedTask = await _todoRepository.updateTask(
        event.task.id,
        event.task.title,
        event.task.description,
      );

      // Update the state with the updated task
      final updatedTasks = state.allTasks.map((task) {
        return task.id == updatedTask.id ? updatedTask : task;
      }).toList();

      // Emit the updated state

      emit(TasksState(allTasks: updatedTasks));
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());
    final updatedTasks =
        state.allTasks.where((task) => task.id != event.task.id).toList();
    emit(TasksState(allTasks: updatedTasks));
  }
}
