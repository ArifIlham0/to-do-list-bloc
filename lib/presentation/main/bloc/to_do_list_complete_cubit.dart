import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';
import 'package:todolist_bloc/service_locator.dart';

class ToDoListCompleteCubit extends Cubit<ToDoListCompleteState> {
  ToDoListCompleteCubit() : super(ToDoListCompleteLoading());

  List<int> selectedTodos = [];
  bool isSelectionMode = false;
  List<DatumToDo> todos = [];

  void onTodoLongPress(int todoId) {
    if (state is ToDoListCompleteLoaded) {
      final currentState = state as ToDoListCompleteLoaded;

      if (selectedTodos.contains(todoId)) {
        selectedTodos.remove(todoId);
        if (selectedTodos.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedTodos.add(todoId);
        isSelectionMode = true;
      }
      emit(
        ToDoListCompleteLoaded(
          todos: currentState.todos,
          isSelectionMode: isSelectionMode,
          selectedTodos: selectedTodos,
        ),
      );
    }
  }

  void deleteSelectedTodos(BuildContext context) async {
    if (selectedTodos.isNotEmpty) {
      emit(ToDoListCompleteLoadingStack(
          todos: state is ToDoListCompleteLoaded
              ? (state as ToDoListCompleteLoaded).todos
              : []));
      var result = await sl<DeleteTodoUseCase>().call(
          params: DeleteTodoParams(ids: GlobalRequest(ids: selectedTodos)));

      result.fold(
        (error) {
          emit(FailureLoadedToDoListComplete(message: error));
          isSelectionMode = false;
          selectedTodos.clear();
        },
        (success) {
          fetchTodosComplete();
          context.read<ToDoListCubit>().fetchTodos();
          context.read<ToDoListOverdueCubit>().fetchTodosOverdue();
          selectedTodos.clear();
          isSelectionMode = false;
        },
      );
    }
  }

  void confirmDeleteSelectedTodos(BuildContext context) {
    customDialog(
      content: "Are you sure want to delete this todo?",
      onConfirm: () {
        deleteSelectedTodos(context);
        Get.back();
      },
    );
  }

  void fetchTodosComplete() async {
    var data = await sl<FetchTodosCompleteUseCase>().call();

    data.fold(
      (error) {
        emit(FailureLoadedToDoListComplete(message: error));
      },
      (data) {
        emit(ToDoListCompleteLoaded(todos: data));
      },
    );
  }

  void updateTodo(String id, ToDoRequest request, BuildContext context) async {
    emit(ToDoListCompleteLoadingStack(
        todos: state is ToDoListCompleteLoaded
            ? (state as ToDoListCompleteLoaded).todos
            : []));
    var result = await sl<UpdateTodoUseCase>()
        .call(params: UpdateTodoParams(id: id, request: request));

    result.fold(
      (error) {
        emit(FailureLoadedToDoListComplete(message: error));
      },
      (data) {
        fetchTodosComplete();
        context.read<ToDoListCubit>().fetchTodos();
        context.read<ToDoListOverdueCubit>().fetchTodosOverdue();
      },
    );
  }
}
