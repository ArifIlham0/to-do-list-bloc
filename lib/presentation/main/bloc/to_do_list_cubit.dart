import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';
import 'package:todolist_bloc/service_locator.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  ToDoListCubit() : super(ToDoListLoading());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  String formattedDateTime = DateTime.now().toUtc().toIso8601String();
  List<int> selectedTodos = [];
  bool isSelectionMode = false;
  List<DatumToDo> todos = [];
  String username = '';

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<String?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        return finalDateTime.toUtc().toIso8601String();
      }
    }
    return null;
  }

  void onTodoTap(
    DatumToDo todo,
    BuildContext context,
    TextEditingController title,
    TextEditingController description,
    String formattedDateTime,
  ) {
    if (isSelectionMode) {
      onTodoLongPress(todo.id ?? 0);
    } else {
      title.text = todo.title ?? '';
      description.text = todo.description ?? '';
      formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.parse(todo.dueDate ?? ""));

      customBottomSheet(
        context: context,
        title: title,
        description: description,
        formKey: formKey,
        onDismiss: () =>
            clearControllers(title, description, formattedDateTime),
        onPressed: () async {
          String? dateTime = await selectDateTime(context);
          if (dateTime != null) {
            formattedDateTime = dateTime;
          }
        },
        onPressed2: () {
          if (validateForm()) {
            updateTodo(
              todo.id.toString(),
              ToDoRequest(
                title: title.text,
                description: description.text,
                dueDate: DateTime.parse(formattedDateTime),
                isCompleted: false,
              ),
              context,
            );
            clearControllers(title, description, formattedDateTime);
            Get.back();
          }
        },
      );
    }
  }

  void markTodoCompleted(DatumToDo todo, BuildContext context) {
    formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.parse(todo.dueDate ?? ""));

    updateTodo(
      todo.id.toString(),
      ToDoRequest(
        title: todo.title,
        description: todo.description,
        dueDate: DateTime.parse(formattedDateTime),
        isCompleted: true,
      ),
      context,
    );
  }

  void onTodoLongPress(int todoId) {
    if (state is ToDoListLoaded) {
      final currentState = state as ToDoListLoaded;

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
        ToDoListLoaded(
          todos: currentState.todos,
          isSelectionMode: isSelectionMode,
          selectedTodos: selectedTodos,
        ),
      );
    }
  }

  void deleteSelectedTodos() async {
    if (selectedTodos.isNotEmpty) {
      emit(ToDoListLoadingStack(
          todos:
              state is ToDoListLoaded ? (state as ToDoListLoaded).todos : []));
      var result = await sl<DeleteTodoUseCase>().call(
          params: DeleteTodoParams(ids: GlobalRequest(ids: selectedTodos)));

      result.fold(
        (error) {
          emit(FailureLoadedToDoList(message: error));
          isSelectionMode = false;
          selectedTodos.clear();
        },
        (success) {
          fetchTodos();
          selectedTodos.clear();
          isSelectionMode = false;
        },
      );
    }
  }

  void addTodo(ToDoRequest model, BuildContext context) async {
    emit(ToDoListLoadingStack(
        todos: state is ToDoListLoaded ? (state as ToDoListLoaded).todos : []));
    var result = await sl<CreateTodoUseCase>().call(params: model);

    result.fold(
      (error) {
        emit(FailureLoadedToDoList(message: error));
      },
      (newTodo) {
        fetchTodos();
        context.read<ToDoListOverdueCubit>().fetchTodosOverdue();
      },
    );
  }

  void openAddTodoModal(BuildContext context, TextEditingController title,
      TextEditingController description) {
    customBottomSheet(
      context: context,
      title: title,
      description: description,
      formKey: formKey,
      onDismiss: () => clearControllers(
          title, description, DateTime.now().toUtc().toIso8601String()),
      onPressed: () async {
        String? dateTime = await selectDateTime(context);
        if (dateTime != null) {
          formattedDateTime = dateTime;
        }
      },
      onPressed2: () {
        if (validateForm()) {
          addTodo(
            ToDoRequest(
              title: title.text,
              description: description.text,
              dueDate: DateTime.parse(formattedDateTime),
              isCompleted: false,
            ),
            context,
          );

          clearControllers(title, description, formattedDateTime);
          Get.back();
        }
      },
    );
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

  void fetchUserPreferences() async {
    String? usernamePref = await StorageHelper().getString("username");

    if (usernamePref != null) {
      username = usernamePref;
    }
  }

  void fetchTodos() async {
    var data = await sl<FetchTodosUseCase>().call();

    data.fold(
      (error) {
        emit(FailureLoadedToDoList(message: error));
      },
      (data) {
        emit(ToDoListLoaded(todos: data));
      },
    );
  }

  void createTodo(ToDoRequest request) async {
    var result = await sl<CreateTodoUseCase>().call(params: request);

    result.fold(
      (error) {
        emit(FailureLoadedToDoList(message: error));
      },
      (data) {
        fetchTodos();
      },
    );
  }

  void updateTodo(String id, ToDoRequest request, BuildContext context) async {
    emit(ToDoListLoadingStack(
        todos: state is ToDoListLoaded ? (state as ToDoListLoaded).todos : []));
    var result = await sl<UpdateTodoUseCase>()
        .call(params: UpdateTodoParams(id: id, request: request));

    result.fold(
      (error) {
        emit(FailureLoadedToDoList(message: error));
      },
      (data) {
        fetchTodos();
        context.read<ToDoListCompleteCubit>().fetchTodosComplete();
      },
    );
  }

  void deleteTodo(GlobalRequest ids) async {
    var result =
        await sl<DeleteTodoUseCase>().call(params: DeleteTodoParams(ids: ids));

    result.fold(
      (error) {
        emit(FailureLoadedToDoList(message: error));
      },
      (data) {
        fetchTodos();
      },
    );
  }

  void clearControllers(TextEditingController title,
      TextEditingController description, String formattedDateTime) {
    title.clear();
    description.clear();
    formattedDateTime = DateTime.now().toUtc().toIso8601String();
  }
}
