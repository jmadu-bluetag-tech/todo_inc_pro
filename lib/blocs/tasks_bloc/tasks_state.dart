part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  final List<Task> allTasks;
  const TasksLoadedState({this.allTasks = const <Task>[]});

  @override
  List<Object> get props => [allTasks];
}

class TasksErrorState extends TasksState {
  final String message;
  const TasksErrorState(this.message);

  @override
  List<Object> get props => [message];
}
