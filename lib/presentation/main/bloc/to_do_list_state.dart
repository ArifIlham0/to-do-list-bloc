import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';

abstract class ToDoListState {}

class ToDoListLoading extends ToDoListState {}

class ToDoListLoadingStack extends ToDoListState {
  final List<DatumToDo> todos;

  ToDoListLoadingStack({required this.todos});
}

class ToDoListLoaded extends ToDoListState {
  ToDoListLoaded({
    required this.todos,
    this.isSelectionMode = false,
    this.selectedTodos = const [],
  });

  final List<DatumToDo> todos;
  final bool isSelectionMode;
  final List<int> selectedTodos;
}

class FailureLoadedToDoList extends ToDoListState {
  FailureLoadedToDoList({required this.message});

  final String message;
}
