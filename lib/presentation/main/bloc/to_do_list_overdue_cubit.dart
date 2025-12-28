import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/presentation/main/bloc/to_do_list_overdue_state.dart';
import 'package:todolist_bloc/service_locator.dart';

class ToDoListOverdueCubit extends Cubit<ToDoListOverdueState> {
  ToDoListOverdueCubit() : super(ToDoListOverdueLoading());

  List<int> selectedTodos = [];
  bool isSelectionMode = false;
  List<DatumToDo> todos = [];

  void onTodoLongPress(int todoId) {
    if (state is ToDoListOverdueLoaded) {
      final currentState = state as ToDoListOverdueLoaded;

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
        ToDoListOverdueLoaded(
          todos: currentState.todos,
          isSelectionMode: isSelectionMode,
          selectedTodos: selectedTodos,
        ),
      );
    }
  }

  void deleteSelectedTodos() async {
    if (selectedTodos.isNotEmpty) {
      emit(ToDoListOverdueLoadingStack(
          todos: state is ToDoListOverdueLoaded
              ? (state as ToDoListOverdueLoaded).todos
              : []));
      var result = await sl<DeleteTodoUseCase>().call(
          params: DeleteTodoParams(ids: GlobalRequest(ids: selectedTodos)));

      result.fold(
        (error) {
          emit(FailureLoadedToDoListOverdue(message: error));
          isSelectionMode = false;
          selectedTodos.clear();
        },
        (success) {
          fetchTodosOverdue();
          selectedTodos.clear();
          isSelectionMode = false;
        },
      );
    }
  }

  void confirmDeleteSelectedTodos() {
    customDialog(
      content: "Are you sure want to delete this todo?",
      onConfirm: () {
        deleteSelectedTodos();
        Get.back();
      },
    );
  }

  void fetchTodosOverdue() async {
    var data = await sl<FetchTodosOverdueUseCase>().call();

    data.fold(
      (error) {
        emit(FailureLoadedToDoListOverdue(message: error));
      },
      (data) {
        emit(ToDoListOverdueLoaded(todos: data));
      },
    );
  }
}
