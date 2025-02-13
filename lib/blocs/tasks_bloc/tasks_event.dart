part of 'tasks_bloc.dart';

class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TasksEvent {}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask({required this.task});
  @override
  List<Object> get props => [task];
}

// class UpdateTask extends TasksEvent {
//   final String id;
//   final String title;
//   final String description;

//   const UpdateTask({required this.id, required this.title, required this.description});

//   @override
//   List<Object> get props => [id, title, description];
// }

class UpdateTask extends TasksEvent {
  final Task task;
  const UpdateTask({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}
