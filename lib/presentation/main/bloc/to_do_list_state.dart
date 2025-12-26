import 'package:todolist_bloc/domain/todo/entities/todo.dart';

abstract class ToDoListState {}

class ToDoListLoading extends ToDoListState {}

class ToDoListLoadingStack extends ToDoListState {
  final List<TodoEntity> todos;

  ToDoListLoadingStack({required this.todos});
}

class ToDoListLoaded extends ToDoListState {
  ToDoListLoaded({
    required this.todos,
    this.isSelectionMode = false,
    this.selectedTodos = const [],
  });

  final List<TodoEntity> todos;
  final bool isSelectionMode;
  final List<int> selectedTodos;
}

class FailureLoadedToDoList extends ToDoListState {
  FailureLoadedToDoList({required this.message});

  final String message;
}
