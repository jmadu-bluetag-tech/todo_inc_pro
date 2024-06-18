import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/task.dart';
import '../../services/respositories.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TodoRepository _todoRepository;
  TasksBloc(this._todoRepository) : super(TasksLoadingState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      final tasks = await _todoRepository.fetchTask();
      emit(TasksLoadedState(allTasks: tasks));
    } catch (e) {
      emit(TasksErrorState('Error fetching tasks: ${e.toString()}'));
    }
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    try {
      // emit(TasksLoadingState());
      final newTask = await _todoRepository.createTask(
          event.task.title, event.task.description);
      final updatedTasks = List<Task>.from((state as TasksLoadedState).allTasks)
        ..add(newTask);

      emit(TasksLoadedState(allTasks: updatedTasks));
    } catch (e) {
      emit(TasksErrorState('Error adding task: ${e.toString()}'));
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    try {
      final updatedTask = await _todoRepository.updateTask(
        event.task.id,
        event.task.title,
        event.task.description,
      );
      final updatedTasks = (state as TasksLoadedState).allTasks.map((task) {
        return task.id == updatedTask.id ? updatedTask : task;
      }).toList();
      emit(TasksLoadedState(allTasks: updatedTasks));
    } catch (e) {
      emit(TasksErrorState('Error updating task: ${e.toString()}'));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    try {
      final updatedTasks = (state as TasksLoadedState)
          .allTasks
          .where((task) => task.id != event.task.id)
          .toList();
      emit(TasksLoadedState(allTasks: updatedTasks));
    } catch (e) {
      emit(TasksErrorState('Error deleting task: ${e.toString()}'));
    }
  }
}
