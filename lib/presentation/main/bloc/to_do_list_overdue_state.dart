import 'package:todolist_bloc/domain/todo/entities/todo.dart';

abstract class ToDoListOverdueState {}

class ToDoListOverdueLoading extends ToDoListOverdueState {}

class ToDoListOverdueLoadingStack extends ToDoListOverdueState {
  final List<TodoEntity> todos;

  ToDoListOverdueLoadingStack({required this.todos});
}

class ToDoListOverdueLoaded extends ToDoListOverdueState {
  ToDoListOverdueLoaded({
    required this.todos,
    this.isSelectionMode = false,
    this.selectedTodos = const [],
  });

  final List<TodoEntity> todos;
  final bool isSelectionMode;
  final List<int> selectedTodos;
}

class FailureLoadedToDoListOverdue extends ToDoListOverdueState {
  FailureLoadedToDoListOverdue({required this.message});

  final String message;
}
