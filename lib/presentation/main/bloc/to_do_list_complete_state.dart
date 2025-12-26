import 'package:todolist_bloc/domain/todo/entities/todo.dart';

abstract class ToDoListCompleteState {}

class ToDoListCompleteLoading extends ToDoListCompleteState {}

class ToDoListCompleteLoadingStack extends ToDoListCompleteState {
  final List<TodoEntity> todos;

  ToDoListCompleteLoadingStack({required this.todos});
}

class ToDoListCompleteLoaded extends ToDoListCompleteState {
  ToDoListCompleteLoaded({
    required this.todos,
    this.isSelectionMode = false,
    this.selectedTodos = const [],
  });

  final List<TodoEntity> todos;
  final bool isSelectionMode;
  final List<int> selectedTodos;
}

class FailureLoadedToDoListComplete extends ToDoListCompleteState {
  FailureLoadedToDoListComplete({required this.message});

  final String message;
}
