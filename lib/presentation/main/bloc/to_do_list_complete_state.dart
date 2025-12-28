import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';

abstract class ToDoListCompleteState {}

class ToDoListCompleteLoading extends ToDoListCompleteState {}

class ToDoListCompleteLoadingStack extends ToDoListCompleteState {
  final List<DatumToDo> todos;

  ToDoListCompleteLoadingStack({required this.todos});
}

class ToDoListCompleteLoaded extends ToDoListCompleteState {
  ToDoListCompleteLoaded({
    required this.todos,
    this.isSelectionMode = false,
    this.selectedTodos = const [],
  });

  final List<DatumToDo> todos;
  final bool isSelectionMode;
  final List<int> selectedTodos;
}

class FailureLoadedToDoListComplete extends ToDoListCompleteState {
  FailureLoadedToDoListComplete({required this.message});

  final String message;
}
